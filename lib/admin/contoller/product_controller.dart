// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:test_run/admin/product/product_model/product_list/products_list.dart';
//
// class ProductController extends GetxController {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   late CollectionReference productCollection;
//
//   TextEditingController productNameCtrl = TextEditingController();
//   TextEditingController productDescriptionCtrl = TextEditingController();
//   TextEditingController productImgCtrl = TextEditingController();
//   TextEditingController productPriceCtrl = TextEditingController();
//
//   String category = 'Category';
//   String yarn_type = 'Yarn Type';
//   String avalability = 'Pre-Order';
//
//   List<Product> products = [];
//
//   @override
//   void onInit() async {
//     productCollection = firestore.collection('products');
//     await fetchProducts();
//     super.onInit();
//   }
//
//   addProduct() async {
//     try {
//       DocumentReference doc = productCollection.doc();
//       Product product = Product(
//         id: doc.id,
//         name: productNameCtrl.text,
//         category: category,
//         description: productDescriptionCtrl.text,
//         price: double.tryParse(productPriceCtrl.text),
//         yarn_type: yarn_type,
//         image: productImgCtrl.text,
//         availability: avalability,
//       );
//       final productJson = product.toJson();
//
//       await doc.set(productJson);
//       await fetchProducts();
//
//       showToast('Product added successfully', isSuccess: true);
//       setValuesDefault();
//     } catch (e) {
//       showToast('Error: ${e.toString()}', isSuccess: false);
//       print(e);
//     }
//   }
//
//   fetchProducts() async {
//     try {
//       QuerySnapshot productSnapshot = await productCollection.get();
//       final List<Product> retrievedProducts = productSnapshot.docs
//           .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
//           .toList();
//       products.clear();
//       products.assignAll(retrievedProducts);
//     } catch (e) {
//       print(e);
//       showToast('Failed to fetch products. Please try again.', isSuccess: false);
//     } finally {
//       update();
//     }
//   }
//
//   deleteProduct(String id) async {
//     try {
//       await productCollection.doc(id).delete();
//       fetchProducts();
//       showToast('Product deleted successfully', isSuccess: true);
//     } catch (e) {
//       showToast('Failed to delete product. Please try again.', isSuccess: false);
//       print(e);
//     }
//   }
//
//
//   void updateProduct(String id, String name, double price) async {
//
//     await FirebaseFirestore.instance.collection('products').doc(id).update({
//       'name': name,
//       'price': price,
//     });
//
//
//     final index = products.indexWhere((product) => product.id == id);
//     if (index != -1) {
//       products[index] = Product(
//         id: id,
//         name: name,
//         price: price,
//       );
//       update();
//     }
//     }
//   // void updateProduct(String id, String name, double price) {
//   //   final index = products.indexWhere((product) => product.id == id);
//   //   if (index != -1) {
//   //     products[index] = Product(
//   //       id: id,
//   //       name: name,
//   //       price: price,
//   //     );
//   //     update();
//   //   }
//   // }
//
//   setValuesDefault() {
//     productNameCtrl.clear();
//     productDescriptionCtrl.clear();
//     productImgCtrl.clear();
//     productPriceCtrl.clear();
//     category = 'not specified';
//     yarn_type = 'not selected';
//     avalability = 'Pre-Order';
//     update();
//   }
//
//   void showToast(String message, {bool isSuccess = true}) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: isSuccess ?  Color.fromRGBO(96,81,81, 1.0) : Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }
//
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_run/admin/product/product_model/product_list/products_list.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  final SupabaseClient supabase = Supabase.instance.client;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'Category';
  String yarn_type = 'Yarn Type';
  String avalability = 'Pre-Order';
  String? imageUrl;

  List<Product> products = [];

  @override
  void onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = await pickedFile.readAsBytes();
      final fileName = '${DateTime.now().toIso8601String()}.jpg';
      final response = await supabase
          .storage
          .from('product_images')
          .uploadBinary(fileName, file);

      if (response.error == null) {
        imageUrl = supabase.storage.from('product_images').getPublicUrl(fileName);
        update();
      }
    }
  }

  addProduct() async {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        yarn_type: yarn_type,
        image: imageUrl ?? '', // Use the imageUrl from Supabase
        availability: avalability,
      );
      final productJson = product.toJson();

      await doc.set(productJson);
      await fetchProducts();

      showToast('Product added successfully', isSuccess: true);
      setValuesDefault();
    } catch (e) {
      showToast('Error: ${e.toString()}', isSuccess: false);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
    } catch (e) {
      print(e);
      showToast('Failed to fetch products. Please try again.', isSuccess: false);
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
      showToast('Product deleted successfully', isSuccess: true);
    } catch (e) {
      showToast('Failed to delete product. Please try again.', isSuccess: false);
      print(e);
    }
  }

  void updateProduct(String id, String name, double price) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'name': name,
      'price': price,
    });

    final index = products.indexWhere((product) => product.id == id);
    if (index != -1) {
      products[index] = Product(
        id: id,
        name: name,
        price: price,
      );
      update();
    }
  }

  setValuesDefault() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productPriceCtrl.clear();
    category = 'not specified';
    yarn_type = 'not selected';
    avalability = 'Pre-Order';
    imageUrl = null; // Reset imageUrl
    update();
  }

  void showToast(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isSuccess ? Color.fromRGBO(96, 81, 81, 1.0) : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

extension on String {
  get error => null;
}
