import 'package:flutter/material.dart';
import 'package:test_run/Customer/widget/multi_select_ddb.dart';
import 'package:test_run/Customer/widget/productcard.dart';

import '../admin/product/widgets/drop_down_btn.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key}); // Use const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('All Products',style: TextStyle(fontWeight: FontWeight.bold),),

    ),
    body:  Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Chip(label: Text('Category')),
              );

          }),
        ),
        Row(
          children: [
            Flexible(
              child: DropDownBtn(items:['Price: Low to High','Price: High to Low'],
                selectedItemText:'Sort',
                onSelected: (selected){},
              ),
            ),
            Flexible(child: MultiSelectDdb(items: [ 'Flowers',
              'Home Decors',
              'Accecories',
              'Clothing',
              'Plushies'], onSelectionChanged: (SelectedItems ) {  },)),
          ],
        ),
        Expanded(
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
              itemCount: 10,
              itemBuilder: (context,index){
            return ProductCard(
              name: 'Mushroom',
              imageUrl: 'https://www.thefriendlyredfox.com/wp-content/uploads/2023/10/IMG_6073-1.jpg',
              price: 500, onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDescription()),);
            },
            );
          }),
        )



      ],
    ),
  );
  }
}