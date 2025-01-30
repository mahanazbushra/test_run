import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_run/Customer/controller_customer/product_cus_controller.dart';
import 'package:test_run/Customer/ProductCustomer/productdes.dart';
import 'package:test_run/Customer/widget/multi_select_ddb.dart';
import 'package:test_run/Customer/widget/productcard.dart';

import '../../admin/product/widgets/drop_down_btn.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key}); // Use const constructor

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCustomerController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async { ctrl.fetchProducts(); },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'All Products', style: TextStyle(fontWeight: FontWeight.bold),),

          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          ctrl.filterByCategory(ctrl.productCategory[index].name?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Chip(label: Text(ctrl.productCategory[index].name ?? 'Error')),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      items: ['Price: Low to High', 'Price: High to Low'],
                      selectedItemText: 'Sort',
                      onSelected: (selected) {},
                    ),
                  ),
                  Flexible(child: MultiSelectDdb(items: [ 'Flowers',
                    'Home Decors',
                    'Accecories',
                    'Clothing',
                    'Plushies'], onSelectionChanged: (SelectedItems) {},)),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No name',
                        imageUrl: ctrl.productShowInUi[index].image ?? 'url',
                        price: ctrl.productShowInUi[index].price ?? 00,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ProductDescription()),);
                        },
                      );
                    }),
              )


            ],
          ),
        ),
      );
    });
  }
}