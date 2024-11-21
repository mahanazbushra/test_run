




// import 'package:flutter/material.dart';
//
// class HomeActivity extends StatefulWidget{
//   const HomeActivity ({Key? key }): super(key: key );
//   @override
//   State<HomeActivity> createState() => _HomeActivityState();
// }
//
// class _HomeActivityState extends State<HomeActivity>{
//   @override
//   Widget build (BuildContext)
//   {
//     return Scaffold(
//       body: Text('signed in'),
//     );
//   }
// }


//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:test_run/login.dart';




class HomeActivity extends StatelessWidget{//this is activity page
  const HomeActivity({super.key});//constructor

  MySnackBar(message,context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))


    );

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Crochet O' clock"),

        titleSpacing: 10,
        //centerTitle: true,
        toolbarHeight: 60,
        toolbarOpacity: 1,
        elevation: 0,
        backgroundColor: Color.fromRGBO(96,81,81, 1.0),
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){MySnackBar("Notification", context);}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: (){MySnackBar("Categories", context);}, icon: const Icon(Icons.category_outlined)),//buid in icon


        ],//array
        //floating action button



      ),//icon actionbar notification icon//title
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color.fromRGBO(96,81,81, 1.0),
        foregroundColor: Colors.white,
        onPressed: (){
          MySnackBar("Add to Cart", context);

        },
        child: Icon(Icons.shopping_cart),//for icon

      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message),label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),


        ],
        onTap: (int index){
          if(index==0){
            MySnackBar("Notifications", context);
          }

          if(index==1){
            MySnackBar("Home", context);
          }

          if(index==2){
            MySnackBar("Profile", context);
          }


        },


      ),

      drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(child: Text("Crochet O' clock")),

              ListTile(leading: Icon (Icons.shopping_bag_outlined),title: Text("My Orders")),
              ListTile(leading: Icon (Icons.rate_review_outlined),title: Text("Review")),
              ListTile(leading: Icon (Icons.local_offer_outlined),title: Text("Vouchers and Offers")),
              ListTile(leading: Icon (Icons.event_available),title: Text("Yarn Stock")),
              ListTile(leading: Icon (Icons.delivery_dining_outlined),title: Text("Delivery Policy")),
              ListTile(title: Text("Return and Refund Policy")),
              ListTile(title: Text("Terms and Conditions")),
              ListTile(title: Text("Privacy and Policy")),
              ListTile(title: Text("Logout")),

            ],

          ),//list view inside contains children




      ),
      /*
      appBar:(),
      body: Text("Hello"),
      drawer: (),//leftnavigationdrawer
      endDrawer: (),
      bottomNavigationBar: (),
      floatingActionButton:(),



*/


    );
  }


}
