// import 'package:flutter/material.dart';
// import 'product.dart';
// import 'product_form.dart';
//
// class ProductDetailPage extends StatelessWidget {
//   final Product product;
//   final bool isEditing;
//
//   const ProductDetailPage({
//     super.key,
//     required this.product,
//     this.isEditing = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEditing ? 'Edit Product' : 'Product Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isEditing
//             ? ProductForm(
//           initialProduct: product,
//         )
//             : Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: 200,
//                 height: 200,
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               product.name,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               product.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '\$${product.price.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }