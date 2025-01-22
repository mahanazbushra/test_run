
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ... your other methods ...
// class HomeActivity extends StatelessWidget {
//   //this is activity page
//   const HomeActivity({super.key}); //constructor
//
//   MySnackBar(message, context) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message))
//     );
//   }
  void MySnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  @override

  Widget build(BuildContext context) {

    //return Builder(
      //builder: (BuildContext context) {
        return Scaffold(

          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Crochet O' clock"),

            titleSpacing: 10,
            //centerTitle: true,
            toolbarHeight: 60,
            toolbarOpacity: 1,
            elevation: 0,
            backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
            foregroundColor: Colors.white,

            leading: IconButton( // Add this IconButton
              icon: const Icon(Icons.menu),
              onPressed: () {
                //Scaffold.of(context).openDrawer();
                _scaffoldKey.currentState?.openDrawer();
              },
            ),

            actions: [
              IconButton(onPressed: () {
                MySnackBar("Notification", context);
              }, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () {
                MySnackBar("Categories", context);
              }, icon: const Icon(Icons.category_outlined)), //buid in icon


            ], //array
            //floating action button


          ),
          //icon actionbar notification icon//title
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: Color.fromRGBO(96, 81, 81, 1.0),
            foregroundColor: Colors.white,
            onPressed: () {
              MySnackBar("Add to Cart", context);
            },
            child: Icon(Icons.shopping_cart), //for icon

          ),

          bottomNavigationBar: BottomNavigationBar(

            currentIndex: 1,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),


            ],
            onTap: (int index) {
              if (index == 0) {
                MySnackBar("Notifications", context);
              }

              if (index == 1) {
                MySnackBar("Home", context);
              }

              if (index == 2) {
                MySnackBar("Profile", context);
              }
            },


          ),

          drawer: Drawer(
            child: ListView(

              // padding: EdgeInsets.zero,
              children:  [
                DrawerHeader(
                    child:
                    Text("Crochet O' clock")),

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
                    },
                ),
                ListTile(leading: Icon(Icons.rate_review_outlined),
                    title: Text("Review")),
                ListTile(leading: Icon(Icons.local_offer_outlined),
                    title: Text("Vouchers and Offers")),
                ListTile(leading: Icon(Icons.event_available),
                    title: Text("Yarn Stock")),
                ListTile(leading: Icon(Icons.delivery_dining_outlined),
                    title: Text("Delivery Policy")),
                ListTile(title: Text("Return and Refund Policy")),
                ListTile(title: Text("Terms and Conditions")),
                ListTile(title: Text("Privacy and Policy")),
                ListTile(title: Text("Logout")),

              ],

            ), //list view inside contains children


          ),
          body: LayoutBuilder(
            builder: (BuildContext context,
                BoxConstraints constraints) {
              return Column(
                children: [
                  _buildSearchBar(context),
                  _buildCarousel(),
                  _buildOnSaleBanner(context, constraints),
                  Expanded(
                    child: Center(
                      child: Text('Other content here'),
                    ),
                  ),
                ],
              );
            }
          ),
        );
      }

  }

  Widget _buildSearchBar(BuildContext context) {
    final TextEditingController _searchController =
    TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SearchBar(
          controller: _searchController,
          leading: const Icon(Icons.search),
          hintText: "I'm seaching for..." ,
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

void showSnackBar(String s, BuildContext context) {
}


  Widget _buildCarousel() {
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
        'asset/sproutling_friends.jpg',
        'asset/kittyspider.jpg',
        'asset/flower_clips.jpg',

      ].map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
            );
          },
        );
      }).toList(),
    );
  }


Widget _buildOnSaleBanner(BuildContext context,
    BoxConstraints constraints) {
  return Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'On Sale',
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildProductCard(context, 'asset/sproutling_friends.jpg','Sproutling Friends',constraints),
            _buildProductCard(context, 'asset/kittyspider.jpg', 'Kitty Spider',constraints),
            _buildProductCard(context, 'asset/flower_clips.jpg', 'Flower clips',constraints),
            _buildProductCard(context, 'asset/sproutling_friends.jpg',"Sproutling Friendss",constraints),
            _buildProductCard(context, 'asset/sproutling_friends.jpg','Sproutling Friends',constraints),
            _buildProductCard(context, 'asset/kittyspider.jpg', 'Kitty Spider',constraints),
            _buildProductCard(context, 'asset/flower_clips.jpg', 'Flower clips',constraints),

          ],
        ),
      ),
    ],
  );
}

Widget _buildProductCard(BuildContext context,
    String imagePath, String productName,
  BoxConstraints constraints) {
  double cardWidth =
  constraints.maxWidth > 600 ? 200 : 150;
  return Container(
  width: cardWidth,
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 3,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return const Icon(Icons.error);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

