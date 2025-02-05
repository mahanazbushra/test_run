import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:test_run/Customer/category/product_category.dart';

import '../../admin/product/product_model/product_list/products_list.dart';

class ProductCustomerController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products =[];
  List<Product> productShowInUi =[];
  List<ProductCategory> productCategory =[];

  @override
  void onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowInUi.assignAll(products);
    } catch (e) {
      print(e);
      showToast('Failed to fetch products. Please try again.', isSuccess: false);
    } finally {
      update();
    }
  }
  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) => ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      productCategory.clear();
      productCategory.assignAll(retrievedCategories);
    } catch (e) {
      print(e);
      showToast('Failed to fetch products. Please try again.', isSuccess: false);
    } finally {
      update();
    }
  }
  filterByCategory (String category)
  {
    productShowInUi.clear();
    productShowInUi = products.where((product) => product.category == category).toList();
    update();

  }


  void filterByYarnType(List<String> yarns) {
    if (yarns.isEmpty) {
      productShowInUi = products;
    } else {
      List<String> lowerCaseYarns = yarns.map((yarn) => yarn.toLowerCase()).toList();
      productShowInUi = products.where((product) =>
      product.yarn_type != null && lowerCaseYarns.contains(product.yarn_type!.toLowerCase())
      ).toList();
    }
    update();
  }
  sortByPrice({required bool ascending})
  {
    List<Product> sortedProducts=List<Product>.from(productShowInUi);
    sortedProducts.sort((a,b)=> ascending? a.price!.compareTo(b.price!): b.price!.compareTo(a.price!));
    productShowInUi =sortedProducts;
    update();
  }



  void showToast(String s, {required bool isSuccess}) {}
}