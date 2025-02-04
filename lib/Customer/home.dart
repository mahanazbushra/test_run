import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_run/Customer/ProductCustomer/productdes.dart';
import 'package:test_run/Customer/ProductCustomer/productinfo.dart';
import 'package:test_run/Customer/controller_customer/product_cus_controller.dart';
import 'package:test_run/Customer/message.dart';
import 'package:test_run/Customer/user_profile.dart';
import 'carousel/febsale.dart';
import 'carousel/pop.dart';
import 'carousel/wintersale.dart';
import 'cart.dart';
import 'drawers/delivery.dart';
import 'drawers/myorders.dart';
import 'drawers/privacy_policy.dart';
import 'drawers/returnpolicy.dart';
import 'drawers/terms_and_conditions.dart';
import 'logout_cus.dart';
import 'notifications.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductCustomerController productController =
      Get.put(ProductCustomerController());

  @override
  void initState() {
    super.initState();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Crochet O' clock"),
        titleSpacing: 10,
        backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Crochet O' clock")),

            // ListTile(leading: Icon(Icons.menu),
            //title: Text('Menu'),
            // onTap: (){
            // Navigator.pop(context);
            // },
            //),

            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text("My Orders"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderListPage(
                      userId: '',
                    ),
                  ),
                );
              },
            ),

            ListTile(
                leading: Icon(Icons.rate_review_outlined),
                title: Text("Review")),
            ListTile(
                leading: Icon(Icons.local_offer_outlined),
                title: Text("Vouchers and Offers")),
            ListTile(
                leading: Icon(Icons.event_available),
                title: Text("Yarn Stock")),
            ListTile(
              leading: Icon(Icons.delivery_dining_outlined),
              title: Text("Delivery Policy"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Delivery(),
                  ),
                );
              },
            ),

            ListTile(
              title: Text("Return and Refund Policy"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReturnRefundPolicyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Terms and Conditions"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsConditionsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Privacy Policy"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogoutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        ),
        child: Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Message()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              _buildSearchBar(context),
              _buildCarousel(),
              _buildOnSaleBanner(context),
              Center(
                child: Text('Other content here'),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        controller: _searchController,
        leading: const Icon(Icons.search),
        hintText: "I'm seaching for...",
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();

              print('Search text cleared');
            },
          ),
        ],
        onTap: () {
          showSnackBar("Search tapped", context);
        },
        onChanged: (value) {
          print('Search text: $value');
        },
      ),
    );
  }

  void showSnackBar(String s, BuildContext context) {}

  Widget _buildCarousel() {
    final List<Widget> carouselPages = [
      const WinterSale(),
      const FebruaryHotDeals(),
      const PopularProducts(),
    ];
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: [
        'asset/carousel001.PNG',
        'asset/carousel02.PNG',
        'asset/carousel03.PNG',
      ].asMap().entries.map((entry) {
        int index = entry.key;
        String imagePath = entry.value;
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WinterSale()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FebruaryHotDeals()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PopularProducts()),
                    );
                    break;
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildOnSaleBanner(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductInfo()),
              );
            },
            child: const Text(
              'All Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
  //       SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: GetBuilder<ProductCustomerController>(
  //           builder: (ctrl) {
  //             if (ctrl.productShowInUi.isEmpty) {
  //               return Center(child: CircularProgressIndicator());
  //             }
  //             return Row(
  //               children: ctrl.productShowInUi.map((product) {
  //                 return _buildProductCard(
  //                   context,
  //                   product.image ?? 'default_image.png',
  //                   product.name ?? 'No Name',
  //                   product.price ?? 0,
  //                   product,
  //                 );
  //               }).toList(),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
        GetBuilder<ProductCustomerController>(
          builder: (ctrl) {
            if (ctrl.productShowInUi.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ctrl.productShowInUi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final product = ctrl.productShowInUi[index];
                return _buildProductCard(
                  context,
                  product.image ?? 'default_image.png',
                  product.name ?? 'No Name',
                  product.price ?? 0,
                  product,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, String imagePath,
      String productName, double price, var product) {
    return InkWell(
      onTap: () {
        Get.to(ProductDescription(), arguments: {'data': product});
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Column(
            children: [
              Image.network(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text("\৳${price.toString()}")
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:test_run/Customer/drawers/delivery.dart';
// import 'package:test_run/Customer/drawers/returnpolicy.dart';
// import 'package:test_run/Customer/ProductCustomer/productinfo.dart';
// import 'package:test_run/Customer/message.dart';
// import 'package:test_run/Customer/user_profile.dart';
//
// import 'carousel/febsale.dart';
// import 'carousel/pop.dart';
// import 'carousel/wintersale.dart';
// import 'cart.dart';
// import 'drawers/myorders.dart';
// import 'logout_cus.dart';
// import 'drawers/privacy_policy.dart';
// import 'drawers/terms_and_conditions.dart';
// import 'notifications.dart';
//
// class HomeActivity extends StatefulWidget {
//   const HomeActivity({super.key});
//
//   @override
//   State<HomeActivity> createState() => _HomeActivityState();
// }
//
// class _HomeActivityState extends State<HomeActivity> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   void MySnackBar(String message, BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
//       key: _scaffoldKey,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Crochet O' clock"),
//
//         titleSpacing: 10,
//         //centerTitle: true,
//         toolbarHeight: 60,
//         toolbarOpacity: 1,
//         elevation: 0,
//         backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
//         foregroundColor: Colors.white,
//
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//
//         actions: [
//           IconButton(
//               onPressed: () {
//                 (
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const NotificationPage(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.notifications)),
//           IconButton(
//               onPressed: () {
//                 MySnackBar("Categories", context);
//               },
//               icon: const Icon(Icons.category_outlined)),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         elevation: 10,
//         backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
//         foregroundColor: Colors.white,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CartPage()),
//           );
//         },
//         child: Icon(Icons.shopping_cart),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
//         elevation: 0,
//         currentIndex: 1,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: "Message",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//         onTap: (int index) {
//           if (index == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const Message(),
//               ),
//             );
//           }
//
//           if (index == 1) {}
//
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const UserProfile(),
//               ),
//             );
//           }
//         },
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(child: Text("Crochet O' clock")),
//
//             // ListTile(leading: Icon(Icons.menu),
//             //title: Text('Menu'),
//             // onTap: (){
//             // Navigator.pop(context);
//             // },
//             //),
//
//             ListTile(
//               leading: const Icon(Icons.shopping_bag_outlined),
//               title: const Text("My Orders"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const OrderListPage(
//                       userId: '',
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//                 leading: Icon(Icons.rate_review_outlined),
//                 title: Text("Review")),
//             ListTile(
//                 leading: Icon(Icons.local_offer_outlined),
//                 title: Text("Vouchers and Offers")),
//             ListTile(
//                 leading: Icon(Icons.event_available),
//                 title: Text("Yarn Stock")),
//             ListTile(
//               leading: Icon(Icons.delivery_dining_outlined),
//               title: Text("Delivery Policy"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const Delivery(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               title: Text("Return and Refund Policy"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ReturnRefundPolicyScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text("Terms and Conditions"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const TermsConditionsScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text("Privacy Policy"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const PrivacyPolicyScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text("Logout"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LogoutPage(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//           return Column(
//             children: [
//               _buildSearchBar(context),
//               _buildCarousel(),
//               _buildOnSaleBanner(context, constraints),
//               Center(
//                 child: Text('Other content here'),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
//
// Widget _buildSearchBar(BuildContext context) {
//   final TextEditingController _searchController = TextEditingController();
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: SearchBar(
//       controller: _searchController,
//       leading: const Icon(Icons.search),
//       hintText: "I'm seaching for...",
//       trailing: [
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             _searchController.clear();
//
//             print('Search text cleared');
//           },
//         ),
//       ],
//       onTap: () {
//         showSnackBar("Search tapped", context);
//       },
//       onChanged: (value) {
//         print('Search text: $value');
//       },
//     ),
//   );
// }
//
// void showSnackBar(String s, BuildContext context) {}
//
// Widget _buildCarousel() {
//   final List<Widget> carouselPages = [
//     const WinterSale(),
//     const FebruaryHotDeals(),
//     const PopularProducts(),
//   ];
//   return CarouselSlider(
//     options: CarouselOptions(
//       height: 200.0,
//       autoPlay: true,
//       enlargeCenterPage: true,
//       aspectRatio: 16 / 9,
//       autoPlayCurve: Curves.fastOutSlowIn,
//       enableInfiniteScroll: true,
//       autoPlayAnimationDuration: const Duration(milliseconds: 800),
//       viewportFraction: 0.8,
//     ),
//     items: [
//       'asset/carousel001.PNG',
//       'asset/carousel02.PNG',
//       'asset/carousel03.PNG',
//     ].asMap().entries.map((entry) {
//       int index = entry.key;
//       String imagePath = entry.value;
//
//       return Builder(
//         builder: (BuildContext context) {
//           return GestureDetector(
//             onTap: () {
//               switch (index) {
//                 case 0:
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const WinterSale()),
//                   );
//                   break;
//                 case 1:
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const FebruaryHotDeals()),
//                   );
//                   break;
//                 case 2:
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const PopularProducts()),
//                   );
//                   break;
//               }
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.error),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     }).toList(),
//   );
// }
//
// Widget _buildOnSaleBanner(BuildContext context, BoxConstraints constraints) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ProductInfo(),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'All Products',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             _buildProductCard(context, 'asset/sproutling_friends.jpg',
//                 'Sproutling Friends', constraints),
//             _buildProductCard(
//                 context, 'asset/kittyspider.jpg', 'Kitty Spider', constraints),
//             _buildProductCard(
//                 context, 'asset/flower_clips.jpg', 'Flower clips', constraints),
//             _buildProductCard(context, 'asset/sproutling_friends.jpg',
//                 "Sproutling Friendss", constraints),
//             _buildProductCard(context, 'asset/sproutling_friends.jpg',
//                 'Sproutling Friends', constraints),
//             _buildProductCard(
//                 context, 'asset/kittyspider.jpg', 'Kitty Spider', constraints),
//             _buildProductCard(
//                 context, 'asset/flower_clips.jpg', 'Flower clips', constraints),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
// Widget _buildProductCard(BuildContext context, String imagePath,
//     String productName, BoxConstraints constraints) {
//   double cardWidth = constraints.maxWidth > 600 ? 200 : 150;
//   return Container(
//     width: cardWidth,
//     padding: const EdgeInsets.all(8.0),
//     child: Card(
//       elevation: 3,
//       child: Column(
//         children: [
//           Image.asset(
//             imagePath,
//             height: 100,
//             width: double.infinity,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               print('Error loading image: $error');
//               return const Icon(Icons.error);
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               productName,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
