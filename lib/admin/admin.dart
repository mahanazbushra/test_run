import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:test_run/admin/product/product_admin.dart';

import 'package:test_run/admin/reports/reports.dart';

import 'package:test_run/admin/users_admin/users.dart';

import '../colors.dart';

import 'logout_admin.dart';
import 'orders/orders.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      color: AppColors.pink2,
      theme: ThemeData(
        cardColor: AppColors.pink4,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardContent(),
    Center(child: Text('Add Items Screen')),
    Center(child: Text('Monthly Sales Screen')),
    Center(child: Text('Reviews Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
        foregroundColor: Color.fromRGBO(96, 81, 81, 1.0),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogoutPageAdmin(),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Color.fromRGBO(96, 81, 81, 1.0),
              )),
        ],
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.selected,
            backgroundColor: AppColors.pink1,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: AppColors.pink6),
                selectedIcon: Icon(Icons.dashboard, color: AppColors.pink3),
                label:
                    Text('Dashboard', style: TextStyle(color: AppColors.pink2)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add, color: AppColors.pink6),
                selectedIcon: Icon(Icons.add, color: AppColors.pink3),
                label:
                    Text('Add Items', style: TextStyle(color: AppColors.pink2)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money, color: AppColors.pink6),
                selectedIcon: Icon(Icons.attach_money, color: AppColors.pink3),
                label: Text('Sales', style: TextStyle(color: AppColors.pink2)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.reviews, color: AppColors.pink6),
                selectedIcon: Icon(Icons.reviews, color: AppColors.pink3),
                label:
                    Text('Reviews', style: TextStyle(color: AppColors.pink2)),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Container(
              color: AppColors.pink4,
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pink4,
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DashboardCard(
              title: 'Users',
              icon: Icons.people,
              count: 150,
              backgroundColor: AppColors.pink4,
              textColor: AppColors.pink3,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersAdmin()),
                );
              },
            );
          } else if (index == 1) {
            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DashboardCard(
                    title: 'Products',
                    icon: Icons.shopping_cart,
                    count: 0,
                    backgroundColor: AppColors.pink4,
                    textColor: AppColors.pink3,
                  );
                }

                if (snapshot.hasError) {
                  return DashboardCard(
                    title: 'Products',
                    icon: Icons.shopping_cart,
                    count: 0,
                    backgroundColor: AppColors.pink4,
                    textColor: AppColors.pink3,
                  );
                }

                int productCount = snapshot.data?.docs.length ?? 0;

                return DashboardCard(
                  title: 'Products',
                  icon: Icons.shopping_cart,
                  count: productCount,
                  backgroundColor: AppColors.pink4,
                  textColor: AppColors.pink3,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductAdmin()),
                    );
                  },
                );
              },
            );
          } else if (index == 2) {
            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('orders').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return DashboardCard(
                    title: 'Orders',
                    icon: Icons.error,
                    count: 0,
                    backgroundColor: AppColors.pink4,
                    textColor: AppColors.pink3,
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DashboardCard(
                    title: 'Orders',
                    icon: Icons.monetization_on,
                    count: 0,
                    backgroundColor: AppColors.pink4,
                    textColor: AppColors.pink3,
                  );
                }

                final orderCount = snapshot.data?.docs.length ?? 0;

                return DashboardCard(
                  title: 'Orders',
                  icon: Icons.monetization_on,
                  count: orderCount,
                  backgroundColor: AppColors.pink4,
                  textColor: AppColors.pink3,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminOrderList()),
                    );
                  },
                );
              },
            );
          } else {
            return DashboardCard(
              title: 'Reports',
              icon: Icons.bar_chart,
              count: 5,
              backgroundColor: AppColors.pink4,
              textColor: AppColors.pink3,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reports()),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: textColor ?? Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '$count',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
