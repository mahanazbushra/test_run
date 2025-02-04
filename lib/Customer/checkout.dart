import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'cart.dart';
import 'drawers/myorders.dart';


class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  const CheckoutPage({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String _errorMessage = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = 'User not logged in.';
          _isLoading = false;
        });
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _addressController.text = userData['address'] ?? '';
          _phoneController.text = userData['phone'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'User data not found.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch user data: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _placeOrder() async {

    if (_nameController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter your name.');
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      setState(() => _errorMessage = 'Please enter a valid email address.');
      return;
    }
    if (_addressController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter your address.');
      return;
    }
    if (!RegExp(r"^\d+$").hasMatch(_phoneController.text)) {
      setState(() => _errorMessage = 'Please enter a valid phone number.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _errorMessage = 'User not authenticated.');
      return;
    }

    try {

      List<Map<String, dynamic>> orderItems = widget.cartItems.map((item) {
        return {
          'name': item.name,
          'price': item.price,
          'quantity': item.quantity,
        };
      }).toList();


      await FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'userEmail': user.email,
        'customerName': _nameController.text,
        'customerEmail': _emailController.text,
        'customerAddress': _addressController.text,
        'customerPhone': _phoneController.text,
        'items': orderItems,
        'totalAmount': widget.totalPrice,
        'orderDate': Timestamp.now(),
        'status': 'Pending',
      });
      final CartController cartController = Get.find<CartController>();
      cartController.items.clear();
      cartController.update();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderListPage(userId: user.uid),
        ),
      );
    } catch (e) {
      setState(() => _errorMessage = 'Error placing order: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Billing Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color.fromRGBO(96, 81, 81, 1.0),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextFormField(_nameController, 'Name'),
            const SizedBox(height: 8),
            _buildTextFormField(_emailController, 'Email',
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 8),
            _buildTextFormField(_addressController, 'Address', maxLines: 3),
            const SizedBox(height: 8),
            _buildTextFormField(_phoneController, 'Phone Number',
                keyboardType: TextInputType.phone),
            const SizedBox(height: 16),


            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color.fromRGBO(96, 81, 81, 1.0),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return ListTile(
                  title: Text(item.name,
                      style: const TextStyle(
                          color: Color.fromRGBO(96, 81, 81, 1.0))),
                  subtitle: Text(
                      'Quantity: ${item.quantity} - Price: \৳${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Color.fromRGBO(96, 81, 81, 1.0))),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(96, 81, 81, 1.0))),
                Text('\৳${widget.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(96, 81, 81, 1.0))),
              ],
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(_errorMessage,
                  style: TextStyle(
                      color: _errorMessage.contains('success')
                          ? Colors.green
                          : Colors.red)),
            const SizedBox(height: 16),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: _placeOrder,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
            //       foregroundColor: Colors.white,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 32, vertical: 12),
            //       textStyle: const TextStyle(fontSize: 18),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: const Text('Place Order'),
            //   ),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed:() {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                        side: BorderSide(color: const Color.fromRGBO(96, 81, 81, 1.0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _placeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Place Order'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      {TextInputType? keyboardType, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
        const TextStyle(color: Color.fromRGBO(96, 81, 81, 1.0)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(96, 81, 81, 1.0)),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Color.fromRGBO(96, 81, 81, 1.0)),
    );
  }
}

