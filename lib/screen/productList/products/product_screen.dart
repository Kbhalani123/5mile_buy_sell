import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/model/product.dart';
import 'package:mile_locally/screen/productList/products/components/productForm.dart';

class ProductView extends StatefulWidget {
  Product? product;

  ProductView(this.product, {super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        iconTheme: IconThemeData(color: AppConstant.cardTextColor),
        title: Text('Manage Product',
            style: TextStyle(
                color: AppConstant.cardTextColor, fontWeight: FontWeight.w500)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ProductForm(widget.product),
          ),
        ),
      ),
    );
  }
}