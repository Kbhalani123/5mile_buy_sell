import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/firebase/firebase_auth.dart';
import 'package:mile_locally/model/product.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final FirebaseService _service = FirebaseService();
  User? _user;
  String? email;

  @override
  void initState() {
    super.initState();
    _user = _service.currentUser;
    email = _user?.email;
    print(email);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.brown.shade200,
        iconTheme: IconThemeData(color: AppConstant.cardTextColor),
        title: Text(
          'Your Products on Sell',
          style: TextStyle(
            color: AppConstant.cardTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _service.getSellProductStream(email: email ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final products = snapshot.data ?? [];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConstant.productView,
                        arguments: product,
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: AppConstant.imageBgColour,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    height: MediaQuery.of(context).size.width * 0.25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: product.imageUrl ?? '',
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product.name ?? 'No Name',
                                              style: TextStyle(
                                                fontSize: AppConstant.titleFontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDeleteDialog(product.id, context);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        _buildDetailText('Category', product.selectedCategory),
                                        SizedBox(height: 5),
                                        _buildDetailText('Price', product.price.toString()),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text.rich(
                              overflow: TextOverflow.ellipsis,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Description: ',
                                    style: TextStyle(
                                      fontSize: AppConstant.subDetailSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: product.description ?? 'No Description',
                                    style: TextStyle(
                                      fontSize: AppConstant.subDetailSize,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade200,
        onPressed: () {
          Navigator.pushNamed(context, AppConstant.productView);
        },
        child: Icon(
          Icons.add,
          color: AppConstant.cardTextColor,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildDetailText(String label, String? value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontSize: AppConstant.subDetailSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value ?? 'N/A',
            style: TextStyle(
              fontSize: AppConstant.subDetailSize,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Future<void> showDeleteDialog(String? proId, BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to delete this product?',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('DELETE'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && proId != null) {
      await _service.deleteProduct(proId);
    }
  }
}

