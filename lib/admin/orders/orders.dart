import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';

class AdminOrderList extends StatelessWidget {
  const AdminOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(96, 81, 81, 1.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('orderDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final order = snapshot.data!.docs[index];
              final data = order.data() as Map<String, dynamic>;
              final orderId = order.id;
              final status = data['status'] ?? 'pending';

              final date = (data['orderDate'] as Timestamp).toDate();
              final formattedDate =
                  DateFormat('MMM dd, yyyy - hh:mm a').format(date);

              return Card(
                color: const Color(0xB6E8BECC),
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  leading: const Icon(
                    Icons.receipt_long,
                    color: AppColors.pink3,
                  ),
                  title: Text(
                    'Order #${order.id.substring(0, 8)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer: ${data['customerName']}'),
                      Text('Total: ৳${data['totalAmount'].toStringAsFixed(2)}'),
                      Text(formattedDate),
                      Text('Transaction ID: ${data['transactionId'] ?? 'N/A'}'),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(status),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOrderSection('Items:', [
                            for (var item in data['items'])
                              '• ${item['name']} (Qty: ${item['quantity']}) - ৳${item['price'].toStringAsFixed(2)}'
                          ]),
                          const SizedBox(height: 10),
                          _buildOrderSection('Customer Details:', [
                            'Email: ${data['customerEmail']}',
                            'Phone: ${data['customerPhone']}',
                            'Address: ${data['customerAddress']}',
                          ]),
                          const SizedBox(height: 20),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.check,
                                    size: 18, color: Colors.white),
                                label: const Text('Approve'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(96, 81, 81, 1.0),
                                  foregroundColor:
                                      Color.fromRGBO(253, 227, 227, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => _confirmUpdateStatus(
                                    context, orderId, 'approved'),
                              ),
                              OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Color.fromRGBO(96, 81, 81, 1.0),
                                ),
                                label: const Text(
                                  'Decline',
                                  style: TextStyle(
                                      color: Color.fromRGBO(96, 81, 81, 1.0)),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color.fromRGBO(96, 81, 81, 1.0),
                                    width: 1.5,
                                  ),
                                  foregroundColor:
                                      const Color.fromRGBO(96, 81, 81, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => _confirmUpdateStatus(
                                    context, orderId, 'declined'),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Color.fromRGBO(253, 227, 227, 1.0),
                                ),
                                label: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(96, 81, 81, 1.0),
                                  foregroundColor:
                                      Color.fromRGBO(253, 227, 227, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () =>
                                    _confirmDeleteOrder(context, orderId),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'declined':
        return Colors.red;
      default:
        return Colors.purple;
    }
  }

  Widget _buildOrderSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        ...items.map((item) => Text(item)).toList(),
      ],
    );
  }

  Future<void> _confirmDeleteOrder(BuildContext context, String orderId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
        surfaceTintColor: Colors.transparent,
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',style: TextStyle(color: Colors.brown)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete order: $e')),
        );
      }
    }
  }

  Future<void> _confirmUpdateStatus(
      BuildContext context, String orderId, String status) async {
    String action = status == 'approved' ? 'approve' : 'decline';
    Color color = status == 'approved' ? Colors.green : Colors.red;

    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
        surfaceTintColor: Colors.transparent,
        title: Text('Confirm $action'),
        content: Text('Are you sure you want to $action this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',style: TextStyle(color: Colors.brown)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action.capitalize(), style: TextStyle(color: color)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .update({'status': status});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order ${action}ed successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to $action order: $e')),
        );
      }
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
