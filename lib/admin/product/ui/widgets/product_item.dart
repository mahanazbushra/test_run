
import 'package:flutter/material.dart';

import '../screens/update_product_screens.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Image.network(
          'https://adminapi.applegadgetsbd.com/storage/media/large/iPhone-14-Starlight-8954.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace)
          {
            print('Error loading image: $error');
            return const Icon(Icons.error);
          },
          //=> const Icon(Icons.error),
        ),
      ),
      title: const Text('Product Name'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: #CODE'),
          Text('Quantity: 12'),

          Text('Product Price: 3542'),
          Text('Total Price: 52465'),
        ],
      ),




      trailing: Wrap(
        children: [
          IconButton(onPressed: () {
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: const Text('Confirm Delete'),
    content: const Text('Do you want to delete this item?'),
    actions: [
    TextButton(
    onPressed: () => Navigator.pop(context),
    child: const Text('Cancel'),
    ),
    TextButton(
    onPressed: () {
    onDelete();
    Navigator.pop(context);
    },
    child: const Text('Yes'),
    ),
    ],
    ),
    );
    },
      icon: const Icon(Icons.delete, color: Colors.red),
    ),
         
          IconButton(onPressed: () {
            Navigator.pushNamed(context, UpdateProductScreen.name);
          }, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }

  void onDelete() {}
}
