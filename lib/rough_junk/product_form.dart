// import 'package:flutter/material.dart';
// import 'products_list.dart';
//
// class ProductForm extends StatefulWidget {
//   final Product? initialProduct;
//   final Function(Product)? onProductUpdated;
//
//   const ProductForm({super.key, this.initialProduct, this.onProductUpdated});
//
//   @override
//   _ProductFormState createState() => _ProductFormState();
// }
//
// class _ProductFormState extends State<ProductForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _priceController;
//   late TextEditingController _imageUrlController;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.initialProduct?.name ?? '');
//     _descriptionController = TextEditingController(text: widget.initialProduct?.description ?? '');_priceController = TextEditingController(text: widget.initialProduct?.price?.toString() ?? '');
//     _imageUrlController = TextEditingController(text: widget.initialProduct?.imageUrl ?? '');
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _priceController.dispose();
//     _imageUrlController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//                 errorStyle: const TextStyle(color: Colors.red),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the product name';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//                 errorStyle: const TextStyle(color: Colors.red),
//               ),
//               maxLines: 3,
//               keyboardType: TextInputType.multiline,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the product description';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: _priceController,
//               decoration: InputDecoration(
//                 labelText: 'Price',
//                 border: OutlineInputBorder(),
//                 errorStyle: const TextStyle(color: Colors.red),
//               ),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the product price';
//                 }
//                 if (double.tryParse(value) == null) {
//                   return 'Please enter a valid number';
//                 }
//                 return null;
//               },),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: _imageUrlController,
//               decoration: InputDecoration(
//                 labelText: 'Image URL',
//                 border: OutlineInputBorder(),
//                 errorStyle: const TextStyle(color: Colors.red),
//               ),
//               keyboardType: TextInputType.url,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the image URL';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             if (_imageUrlController.text.isNotEmpty)
//               SizedBox(
//                 height: 100,
//                 child: Image.network(
//                   _imageUrlController.text,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//                 ),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading
//                   ? null
//                   : () async {
//                 if (_formKey.currentState!.validate()) {
//                   setState(() {
//                     _isLoading = true;
//                   });
//                   final updatedProduct = Product(
//                     id: widget.initialProduct?.id ?? UniqueKey().toString(),
//                     name: _nameController.text,
//                     description: _descriptionController.text,
//                     price: double.parse(_priceController.text),
//                     imageUrl: _imageUrlController.text,
//                   );
//                   if (widget.onProductUpdated != null) {
//                     widget.onProductUpdated!(updatedProduct);
//                   }
//                   setState(() {
//                     _isLoading = false;
//                   });
//                   Navigator.pop(context);
//                 }
//               },
//               child: _isLoading
//                   ? const CircularProgressIndicator()
//                   : Text(widget.initialProduct == null ? 'Add Product' : 'Update Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }