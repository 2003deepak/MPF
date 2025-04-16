import 'package:flutter/material.dart';
import '../main.dart';

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int currentStep = 0;
  final String orderId = 'FDX${DateTime.now().millisecondsSinceEpoch % 100000}';

  @override
  void initState() {
    super.initState();
    _simulateOrderProgress();
  }

  void _simulateOrderProgress() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) setState(() => currentStep = 1);
    });

    Future.delayed(Duration(seconds: 6), () {
      if (mounted) setState(() => currentStep = 2);
    });

    Future.delayed(Duration(seconds: 9), () {
      if (mounted) setState(() => currentStep = 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deliveryAddress = {
      'name': 'Amit Sharma',
      'address': '21, Green Park Avenue',
      'city': 'Bengaluru, Karnataka',
      'pin': '560103',
      'phone': '+91 9876543210'
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Order'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: $orderId',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Estimated Delivery Time: 30-45 mins',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 16),
                    Text('Delivery To:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      '${deliveryAddress['name']}\n${deliveryAddress['address']}\n${deliveryAddress['city']} - ${deliveryAddress['pin']}\nPhone: ${deliveryAddress['phone']}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Progress Tracker
            Text(
              'Order Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Stepper(
              currentStep: currentStep,
              controlsBuilder: (_, __) => const SizedBox.shrink(),
              steps: [
                Step(
                  title: Text('Order Confirmed'),
                  content: Text('Your order has been confirmed by the restaurant.'),
                  isActive: currentStep >= 0,
                  state: currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Being Prepared'),
                  content: Text('Your food is being freshly prepared by our chefs.'),
                  isActive: currentStep >= 1,
                  state: currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Out for Delivery'),
                  content: Text('The delivery partner is on the way to your location.'),
                  isActive: currentStep >= 2,
                  state: currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: Text('Delivered'),
                  content: Text('Your order has been delivered. Party !!'),
                  isActive: currentStep >= 3,
                  state: currentStep >= 3 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item['name']),
                  subtitle: Text('₹${item['price'].toStringAsFixed(2)}'),
                  trailing: Text('x${item['quantity']}'),
                );
              },
            ),

            const Divider(),

            // Total
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    '₹ 1589',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Back Home Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartItems.clear();
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Back to Home', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
