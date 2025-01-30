import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                'https://www.thefriendlyredfox.com/wp-content/uploads/2023/10/IMG_6073-1.jpg',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mushroom',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Product Description',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tk 500',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Enter your Billing Address',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // Add your onPressed logic here
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// class ProductDescription extends StatelessWidget {
//   const ProductDescription({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details',style: TextStyle(fontWeight: FontWeight.bold),),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network('https://www.thefriendlyredfox.com/wp-content/uploads/2023/10/IMG_6073-1.jpg',
//
//           fit: BoxFit.contain,
//           width:double.infinity,
//           height:200,
//         ),
//       ),
//       const SizedBox(height: 20),
//       Text(
//         'Mushroom',
//         style: const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 20),
//       Text(
//         'Product Discription',
//         style:TextStyle(fontSize: 16,height: 1.5),
//       ),
//       const SizedBox(height: 20),
//       Text(
//         'Tk 500',
//         style:TextStyle(
//           fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 20),
//       TextField(
//         maxLines: 3,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           labelText: 'Enter your Billing Address',
//         ),
//       ),
//       const SizedBox(height: 20),
//       SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Color.red,
//             child:const Text(
//               'Buy Now',
//               style: TextStyle(fontSize: 18,color: Color.white),
//
//             ),
//             onPressed:() {
//
//             },
//
//           ),
//         ),
//         ],
//       ),
//     ),
//     );
//   }
// }
//
//
//
//
