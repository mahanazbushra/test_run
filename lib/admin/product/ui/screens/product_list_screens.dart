import 'package:flutter/material.dart';

import '../widgets/product_item.dart';
import 'add_new_product_screens.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ProductItem(

          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
