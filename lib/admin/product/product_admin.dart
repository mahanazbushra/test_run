import 'package:flutter/material.dart';
import 'package:test_run/admin/contoller/product_controller.dart';
import 'package:test_run/admin/product/add_admin_product.dart';
import 'package:test_run/admin/product/update_admin_product.dart';
import 'package:get/get.dart';

class ProductAdmin extends StatelessWidget {
  const ProductAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
        appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: ctrl.products.length,
          itemBuilder: (context, index) {

            final product = ctrl.products[index];

            return ListTile(
              title: Text(product.name ?? ''),
              subtitle: Text((product.price ?? 0).toString()),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ctrl.deleteProduct(product.id ?? '');
                  print('Deleted');
                },
              ),
              onTap: () {

                Get.to(() => ProductUpdate(product: product));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(ProductAdd());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}


