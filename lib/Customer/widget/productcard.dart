import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

final String name;
final String imageUrl;
final double price;
final Function onTap;
const ProductCard({super.key, required this.name, required this.imageUrl, required this.price, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
       onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmWnQyrBdSF74Ntt5fWyTCiT_Do-p6qZ6Mog&s',
                fit:BoxFit.cover,
                width: double.maxFinite,
                height:120,
              ),
              SizedBox(height: 9),
              Text(name,style: TextStyle(fontSize:16),
                overflow: TextOverflow.ellipsis,),
              SizedBox(height: 9),
              Text("BDT : $price",style: TextStyle(fontSize:16),
                overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}
