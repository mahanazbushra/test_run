

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_run/Customer/cart.dart';
import 'package:test_run/admin/product/product_model/product_list/products_list.dart';

import '../checkout.dart';


class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Product product = Get.arguments['data'];

    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227,1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),


            Text(
              product.name ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),


            Text(
              product.description ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),


            Text(
              '৳: ${product.price ?? ''}',
              style: const TextStyle(
                fontSize: 20,
                color:  Color.fromRGBO(96, 81, 81, 1.0),

                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),


            Row(
              children: [
                const Text(
                  'Quantity:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),

                IconButton(
                  onPressed: decrementQuantity,
                  icon: const Icon(Icons.remove_circle_outline, size: 30),
                ),

                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                IconButton(
                  onPressed: incrementQuantity,
                  icon: const Icon(Icons.add_circle_outline, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),


            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_basket_outlined, color: Color.fromRGBO(96, 81, 81, 1.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );

                  },
                ),


                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side:const BorderSide(color: Color.fromRGBO(96, 81, 81, 1.0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {

                      final cartController = Get.find<CartController>();
                      cartController.addItem(CartItem(
                        name: product.name ?? 'No Name',
                        price: product.price ?? 0.0,
                        quantity: quantity,
                        imagePath: product.image ?? '',
                      ));

                    //   Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CartPage(
                    //
                    //     ),
                    //   ),
                    // );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$quantity ${product.name} added to cart!'),
                        ),
                      );
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18, color: Color.fromRGBO(96, 81, 81, 1.0)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),


                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:  const Color.fromRGBO(96, 81, 81, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (quantity == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an item.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      final cartItem = CartItem(
                        name: product.name ?? 'No Name',
                        price: product.price ?? 0.0,
                        quantity: quantity, imagePath: '',
                      );


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            cartItems: [cartItem],
                            totalPrice: (product.price ?? 0.0) * quantity,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:test_run/admin/product/product_model/product_list/products_list.dart';
//
// class ProductDescription extends StatelessWidget {
//   const ProductDescription({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     Product product = Get.arguments['data'];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Product Details',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 product.image ??'',
//                 fit: BoxFit.contain,
//                 width: double.infinity,
//                 height: 200,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               product.name ??'',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//              Text(
//               product.description ??'',
//               style: const TextStyle(fontSize: 16, height: 1.5),
//             ),
//             const SizedBox(height: 20),
//              Text(
//               '৳: ${product.price ?? ''}',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//            /* TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 labelText: 'Enter your Billing Address',
//               ),
//             ),
//             const SizedBox(height: 20),*/
//             // SizedBox(
//             //   width: double.infinity,
//             //   child: ElevatedButton(
//             //     style: ElevatedButton.styleFrom(
//             //       padding: const EdgeInsets.symmetric(vertical: 15),
//             //       backgroundColor: Colors.red,
//             //     ),
//             //     onPressed: () {
//             //       // Add your onPressed logic here
//             //     },
//             //     child: const Text(
//             //       'Buy Now',
//             //       style: TextStyle(fontSize: 18, color: Colors.white),
//             //     ),
//             //   ),
//             // ),
//             Row(
//               children: [
//
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.blue,
//                     ),
//                     onPressed: () {
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Product added to cart!'),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Add to Cart',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//
//
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.red,
//                     ),
//                     onPressed: () {
//
//                       // Get.to(() => CheckoutPage(product: product));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Proceeding to checkout!'),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Buy Now',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
