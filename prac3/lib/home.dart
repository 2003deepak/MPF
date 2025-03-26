import 'package:flutter/material.dart';

// Replace the global cartItems list with a ValueNotifier
final ValueNotifier<List<Map<String, dynamic>>> cartItemsNotifier = 
    ValueNotifier<List<Map<String, dynamic>>>([]);

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Yamaha Grand Piano GB1K',
      'price': 18999.99,
      'description': 'The GB1K is a classic grand piano with a rich, warm tone. Features include a solid spruce soundboard, premium-grade hammer felt, and a sophisticated damper mechanism. Perfect for both home performance and professional studios.',
      'imageUrl': 'https://images-cdn.ubuy.co.in/66e1f5aaf81eec213b6e2177-yamaha-p-45b-digital-piano.jpg',
      'rating': 4.8,
      'reviews': 124,
      'category': 'Piano'
    },
    {
      'name': 'Fender Stratocaster Electric Guitar',
      'price': 1499.99,
      'description': 'The iconic Fender Stratocaster features an alder body, maple neck, and rosewood fingerboard. Includes three single-coil pickups delivering the classic Strat tone.',
      'imageUrl': 'https://vibemusic.in/wp-content/uploads/2024/07/Hertz-LP-Custom-Electric-Guitar-FM.jpeg',
      'rating': 4.9,
      'reviews': 256,
      'category': 'Guitar'
    },
    {
      'name': 'Roland XPS-30',
      'price': 79999.99,
      'description': 'Professional portable piano with PureAcoustic Piano Modeling technology. Features premium keyboard action and powerful onboard speakers.',
      'imageUrl': 'https://m.media-amazon.com/images/I/61eEz7g96GL.jpg',
      'rating': 4.7,
      'reviews': 89,
      'category': 'Piano'
    },
    {
      'name': 'Kadence Guitar',
      'price': 8699.99,
      'description': 'Legendary electric guitar featuring a mahogany body with maple top, Burstbucker pickups, and hand-wired controls for that classic Les Paul sound.',
      'imageUrl': 'https://kadence.in/wp-content/uploads/2023/08/Kadence-A281BK-b-600x600.jpg',
      'rating': 4.9,
      'reviews': 178,
      'category': 'Guitar'
    },
    {
      'name': 'Flute ',
      'price': 1699.99,
      'description': 'A fine woodwind instrument perfect for any aspiring musician. Includes a durable body and exceptional sound quality.',
      'imageUrl': 'https://m.media-amazon.com/images/I/41KAz78MqTL._AC_UF1000,1000_QL80_.jpg',
      'rating': 4.9,
      'reviews': 178,
      'category': 'Flute'
    },
  ];

  void addToCart(BuildContext context, Map<String, dynamic> product) {
    final cartItems = cartItemsNotifier.value;
    int existingIndex = cartItems.indexWhere((item) => item['name'] == product['name']);
    
    if (existingIndex >= 0) {
      cartItems[existingIndex]['quantity'] += 1;
    } else {
      cartItems.add({
        ...product,
        'quantity': 1,
      });
    }
    
    cartItemsNotifier.notifyListeners();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 400 ? 1 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Store'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: cartItemsNotifier,
                builder: (context, cartItems, _) {
                  if (cartItems.isEmpty) return SizedBox.shrink();
                  return Positioned(
                    right: 8,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cartItems.fold<int>(0, (sum, item) => sum + (item['quantity'] as int)).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: screenWidth < 400 ? 1.2 : 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              addToCart: addToCart,
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(BuildContext, Map<String, dynamic>) addToCart;

  const ProductCard({Key? key, required this.product, required this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: product,
              addToCart: addToCart,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    product['imageUrl'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          product['rating'].toString(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${product['reviews']})',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rs ${product['price'].toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(BuildContext, Map<String, dynamic>) addToCart;

  const ProductDetailsPage({Key? key, required this.product, required this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text('${product['rating']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text('(${product['reviews']} reviews)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Rs ${product['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                  SizedBox(height: 16),
                  Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(product['description'], style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5)),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => addToCart(context, product),
                    child: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotalPrice() {
    return cartItemsNotifier.value.fold<double>(
        0, (sum, item) => sum + (item['price'] * (item['quantity'] as int)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: cartItemsNotifier,
              builder: (context, cartItems, _) {
                return cartItems.isEmpty
                    ? Center(child: Text('Your cart is empty'))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Dismissible(
                            key: Key(item['name'] + index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              final removedItem = cartItemsNotifier.value.removeAt(index);
                              cartItemsNotifier.notifyListeners();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${removedItem['name']} removed from cart'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      cartItemsNotifier.value.insert(index, removedItem);
                                      cartItemsNotifier.notifyListeners();
                                    },
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(item['imageUrl'], 
                                  width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(item['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rs ${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove, size: 18),
                                        onPressed: () {
                                          if (item['quantity'] > 1) {
                                            item['quantity'] -= 1;
                                          } else {
                                            cartItemsNotifier.value.removeAt(index);
                                          }
                                          cartItemsNotifier.notifyListeners();
                                        },
                                      ),
                                      Text(item['quantity'].toString()),
                                      IconButton(
                                        icon: Icon(Icons.add, size: 18),
                                        onPressed: () {
                                          item['quantity'] += 1;
                                          cartItemsNotifier.notifyListeners();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: cartItemsNotifier,
            builder: (context, cartItems, _) {
              if (cartItems.isEmpty) return SizedBox.shrink();
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Rs ${getTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Checkout functionality
                        },
                        child: Text('Checkout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}