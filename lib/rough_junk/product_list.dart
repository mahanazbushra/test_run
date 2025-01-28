// import 'package:flutter/material.dart';
// import 'products_list.dart';
// import 'product_detail_page.dart';
//
// class ProductList extends StatelessWidget {
//   final List<Product> products;
//   final Function(String) onDelete;
//
//   const ProductList({
//     super.key,
//     required this.products,
//     required this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return Card(
//           elevation: 4,
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: ListTile(
//             leading: SizedBox(
//               width: 50,
//               height: 50,
//               child: Image.network(
//                 product.imageUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//               ),
//             ),
//             title: Text(product.name),
//             subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailPage(
//                           product: product,
//                           isEditing: true,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () => onDelete(product.id),
//                 ),
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailPage(
//                     product: product,
//                     isEditing: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }