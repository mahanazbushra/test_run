import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_run/admin/contoller/product_controller.dart';
import 'package:test_run/admin/product/product_model/product_list/products_list.dart';


class ProductUpdate extends StatelessWidget {
  final Product product;

  ProductUpdate({super.key, required this.product});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductController ctrl = Get.find<ProductController>();


    nameController.text = product.name ?? '';
    priceController.text = product.price?.toString() ?? '';

    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(
        title: const Text('Update Product'),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: SingleChildScrollView(
          child: Container(
    margin: EdgeInsets.all(20),
    width: double.maxFinite,
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
          children: [
    Text('Update Product',
    style: TextStyle(
    fontSize: 30,
    color: Colors.brown,
    fontWeight: FontWeight.bold,

    ),
    ),
    SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)

    ),
    labelText: 'Product Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration:  InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)

    ),
    labelText: 'Product Price'),


              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
                foregroundColor: Color.fromRGBO(253, 227, 227, 1.0),


              ),
              onPressed: () {
                // Update product in the controller
                ctrl.updateProduct(
                  product.id ?? '',
                  nameController.text,
                  double.tryParse(priceController.text) ?? 0,
                );

                // Go back to the previous screen
                Get.back();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
