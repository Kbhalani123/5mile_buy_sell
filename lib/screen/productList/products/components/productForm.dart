import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/firebase/firebase_auth.dart';
import 'package:mile_locally/model/category.dart';
import 'package:mile_locally/model/product.dart';
import 'package:mile_locally/util/app_utill.dart';
import 'package:mile_locally/widget/customButton.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  const ProductForm(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final List<Category> _categories = [
    Category(name: "Car"),
    Category(name: "Electronics"),
    Category(name: "Household"),
    Category(name: "Clothing"),
    Category(name: "Shoes"),
    Category(name: "Furniture"),
    Category(name: "Jewelry"),
    Category(name: "Cell Phones"),
  ];

  String _name = '';
  String _desc = '';
  XFile? _newImage;
  int? _price;
  String? _selectedCategoryId;
  String _selectedCategory = '';
  String? existingImageUrl;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  final FirebaseService _service = FirebaseService();
  User? _user;
  String? email, gName;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      existingImageUrl = widget.product!.imageUrl;
      _nameController.text = widget.product!.name;
      _descController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _selectedCategoryId = widget.product!.selectedCategory;
      _selectedCategory = _categories
          .firstWhere((cat) => cat.name == _selectedCategoryId, orElse: () => Category(name: '')).name;
    }
    _user = _service.currentUser;
    email = _user?.email;
    gName = _user?.displayName;
    print(email);
  }

  /*void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newImage != null || existingImageUrl != null) {
        _formKey.currentState?.save();
        _service
            .addProduct(
          productId: widget.product?.id,
          gId: email!,
          gName: gName!,
          name: _name,
          desc: _desc,
          price: _price!,
          newImage: _newImage,
          selectedCategory: _selectedCategory,
          createdAt: widget.product?.createdAt,
          existingImageUrl: existingImageUrl,
          context: context,
        )
            .then((value) {
          if (value) {
            print('Product added successfully');
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to add product.'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an Image'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }*/
  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newImage != null || existingImageUrl != null) {
        _formKey.currentState?.save();
        _service
            .addProduct(
          productId: widget.product?.id,
          gId: email!,
          gName: gName!,
          name: _name,
          desc: _desc,
          price: _price!,
          newImage: _newImage,
          selectedCategory: _selectedCategory,
          createdAt: widget.product?.createdAt,
          existingImageUrl: existingImageUrl,
          context: context,
        )
            .then((value) {
          if (value) {
            print('Product added successfully');
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to add product.'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an Image'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }


  Future<void> _pickImage() async {
    final image = await AppUtil.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _newImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Card(
                      child: _newImage == null && existingImageUrl != null
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(existingImageUrl!),
                      )
                          : _newImage != null
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(_newImage!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  keyboardType: TextInputType.name,
                  validator: AppUtil.validateName,
                  onSaved: (value) => _name = value ?? '',
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(labelText: 'Product Description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  validator: AppUtil.validateDescription,
                  onSaved: (value) => _desc = value ?? '',
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: AppUtil.validateValue,
                  onSaved: (value) => _price = int.tryParse(value ?? '') ?? 0,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategoryId,
                  decoration: InputDecoration(labelText: 'Select Category'),
                  items: _categories
                      .map<DropdownMenuItem<String>>((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.name,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value;
                      _selectedCategory = _categories
                          .firstWhere((cat) => cat.name == value)
                          .name;
                    });
                  },
                  onSaved: (newValue) {
                    _selectedCategory = newValue ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomButton(
                  backgroundColor: AppConstant.cardColor,
                  text: widget.product != null ? 'Update Product' : 'Add Product',
                  textColor: AppConstant.cardTextColor,
                  onClick: () {
                    _submitForm(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
