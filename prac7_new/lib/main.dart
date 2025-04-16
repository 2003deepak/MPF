import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_tracking_screen.dart';

// Global cart data
List<Map<String, dynamic>> cartItems = [];

// Calculate total amount
double getCartTotal() {
  double total = 0;
  for (var item in cartItems) {
    total += (item['price'] * item['quantity']);
  }
  return total;
}

// Get cart item count
int getCartItemCount() {
  int count = 0;
  for (var item in cartItems) {
    count += item['quantity'] as int;
  }
  return count;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFF5722),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFF5722),
          primary: Color(0xFFFF5722),
          secondary: Color(0xFFFF8A65),
        ),
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFF5722),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF5722),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/food-detail': (context) => FoodDetailScreen(),
        '/cart': (context) => CartScreen(),
        '/order-tracking': (context) => OrderTrackingScreen(),
      },
    );
  }
}

