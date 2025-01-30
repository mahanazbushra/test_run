import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_run/admin/contoller/product_controller.dart';
import 'package:test_run/admin/product/widgets/drop_down_btn.dart';


class ProductAdd extends StatelessWidget {
  const ProductAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
        appBar: AppBar(title: Text('Add Product'),
          backgroundColor: Colors.transparent,
          elevation: 0,),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Add New Product',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller:  ctrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      label: Text('Product Name'),
                      hintText: 'Enter Product Name'
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      label: Text('Description'),
                      hintText: 'Enter Product Description'
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                // TextField(
                //   controller: ctrl.productImgCtrl,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)
                //
                //       ),
                //       label: Text('Product Image'),
                //       hintText: 'Enter Product Image URL'
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () => ctrl.pickImage(),
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.grey),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: ctrl.imageUrl == null
                //         ? Text('Tap to upload an image')
                //         : Image.network(ctrl.imageUrl!),
                //   ),
                // ),
                GestureDetector(
                  onTap: () => ctrl.pickImage(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ctrl.imageUrl == null
                        ? Text('Tap to upload an image')
                        : Image.network(ctrl.imageUrl!),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      label: Text('Product Price'),
                      hintText: 'Enter Product Price'
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                          items: [
                            'Flowers',
                            'Home Decors',
                            'Accecories',
                            'Clothing',
                            'Plushies'
                          ],
                          //state management kora hoise
                          selectedItemText: ctrl.category,
                          onSelected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'Not Specified';
                          ctrl.update();
                          },)),
                    Flexible(
                        child: DropDownBtn(
                          items: [
                            'Fleece Yarn',
                            'Milk Cotton',
                            'Acrylic',
                            'Butter Yarn',
                            'Plush yarn'
                          ],
                          selectedItemText: ctrl.yarn_type,
                          onSelected: (selectedValue) {
                            ctrl.yarn_type = selectedValue ?? 'Not Selected';
                            ctrl.update();
                          },)),
                  ],
                ),


                SizedBox(height: 20),
                Text('About the Product availibality'),
                DropDownBtn(
                  items: ['On sale', 'Pre-Order', 'Available'],
                  selectedItemText: ctrl.avalability,
                  onSelected: (selectedValue) {
                    ctrl.avalability = selectedValue ?? 'Pre-Order';
                    ctrl.update();
                  },
                ),

                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
                      foregroundColor: Color.fromRGBO(253, 227, 227, 1.0),


                    ),

                    onPressed: () { ctrl.addProduct();  Get.back();},

                    child: Text('Add Product'))


              ],
            ),
          ),
        ),
      );
    });
  }
}
