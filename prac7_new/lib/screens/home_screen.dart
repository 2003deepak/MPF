import 'package:flutter/material.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  
final List<Map<String, dynamic>> foodItems = [
  // Appetizers
  {
    'id': 1,
    'name': 'Samosa',
    'description': 'Crispy pastry filled with spiced potatoes and peas.',
    'price': 30,
    'category': 'Appetizers',
    'imageUrl': 'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/samosa-recipe.jpg',
  },
  {
    'id': 2,
    'name': 'Paneer Tikka',
    'description': 'Marinated paneer cubes grilled with bell peppers and onions.',
    'price': 150,
    'category': 'Appetizers',
    'imageUrl': 'https://www.indianveggiedelight.com/wp-content/uploads/2021/08/air-fryer-paneer-tikka-featured.jpg',
  },
  {
    'id': 3,
    'name': 'Vegetable Pakora',
    'description': 'Assorted vegetables dipped in gram flour batter and deep-fried.',
    'price': 50,
    'category': 'Appetizers',
    'imageUrl': 'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/vegetable-pakora-recipe.jpg',
  },
  {
    'id': 4,
    'name': 'Aloo Tikki',
    'description': 'Spiced potato patties shallow-fried until golden brown.',
    'price': 40,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdwCnHUkPH7v1YrW_3CucQtxH1B4CzvyjAJA&s',
  },
  {
    'id': 5,
    'name': 'Dahi Puri',
    'description': 'Crispy puris filled with spiced potatoes, topped with yogurt and chutneys.',
    'price': 60,
    'category': 'Appetizers',
    'imageUrl': 'https://ministryofcurry.com/wp-content/uploads/2022/07/Dahi-Puri_-3.jpg',
  },
  {
    'id': 6,
    'name': 'Hara Bhara Kabab',
    'description': 'Spinach and green pea patties flavored with spices.',
    'price': 70,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfCorS3ggj3x0dBTMe_w4TdbeF0q3tznOdkg&s',
  },
  {
    'id': 7,
    'name': 'Dhokla',
    'description': 'Steamed fermented rice and chickpea flour cake, tempered with mustard seeds.',
    'price': 50,
    'category': 'Appetizers',
    'imageUrl': 'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/khaman-dhokla-recipe.webp',
  },
  {
    'id': 8,
    'name': 'Pani Puri',
    'description': 'Hollow puris filled with spicy tamarind water and flavored potatoes.',
    'price': 40,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTTCh85mJmhYcPyMWM5jI2RT4OBssRVwBDIQ&s',
  },
  {
    'id': 9,
    'name': 'Sev Puri',
    'description': 'Flat puris topped with diced potatoes, onions, chutneys, and sev.',
    'price': 50,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs45MBSjs_xFwLMGsopfYdN0KuHtjKlRZpjQ&s',
  },
  {
    'id': 10,
    'name': 'Kachori',
    'description': 'Flaky pastry filled with spiced lentils or peas.',
    'price': 35,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQW_KRVbpU4w-AHK9OGKzG2s41uE1uUsISog&s',
  },
  {
    'id': 11,
    'name': 'Masala Papad',
    'description': 'Crispy papad topped with chopped onions, tomatoes, and spices.',
    'price': 30,
    'category': 'Appetizers',
    'imageUrl': 'https://www.flavourstreat.com/wp-content/uploads/2022/05/masala-papad-001.jpg',
  },
  {
    'id': 12,
    'name': 'Corn Chaat',
    'description': 'Spicy and tangy corn salad mixed with onions, tomatoes, and chutneys.',
    'price': 60,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVLahd3pHlrkw242vlpAv0fevY7a6GVtpX6Q&s',
  },
  {
    'id': 14,
    'name': 'Vegetable Spring Rolls',
    'description': 'Crispy rolls stuffed with mixed vegetables and noodles.',
    'price': 70,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWf95f_q_NhCWcF_1IjCS9uYmuFAu_sWfVIw&s',
  },
  {
    'id': 15,
    'name': 'Chilli Paneer',
    'description': 'Paneer cubes tossed in a spicy and tangy Indo-Chinese sauce.',
    'price': 120,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLL7ELazVbZPsu6A-qDZrMCtq9h6ZR8iMGMA&s',
  },
  {
    'id': 16,
    'name': 'Stuffed Mushrooms',
    'description': 'Mushrooms filled with spiced paneer and vegetables, baked to perfection.',
    'price': 130,
    'category': 'Appetizers',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwKVwmrLcNjJAqD-fMY4SRTERw9mSglVSsqg&s',
  },
  {
    'id': 17,
    'name': 'Vegetable Seekh Kebab',
    'description': 'Minced vegetables mixed with spices, skewered and grilled.',
    'price': 110,
    'category': 'Appetizers',
    'imageUrl': 'https://i.imgur.com/21ZJQ9X.jpg',
  },
  
  // Pizza Category
  {
    'id': 20,
    'name': 'Margherita Pizza',
    'description': 'Classic Italian pizza with fresh tomatoes, mozzarella, and basil',
    'price': 299,
    'category': 'Pizza',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZk4UPpIsuM1lvkV36tCE20R199V3iRx9FFQ&s',
  },
  {
    'id': 21,
    'name': 'Pepperoni Pizza',
    'description': 'Spicy pepperoni slices with melted cheese on tomato base',
    'price': 349,
    'category': 'Pizza',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNXGxFm0EzOU0DKwp78dJ-TDETo_XQaGUaPw&s',
  },
  {
    'id': 22,
    'name': 'Veg Supreme Pizza',
    'description': 'Loaded with mushrooms, onions, capsicum, olives, and sweet corn',
    'price': 379,
    'category': 'Pizza',
    'imageUrl': 'https://salasdaily.com/cdn/shop/products/vegsupremepizza.jpg?v=1669966966',
  },

  // Burger Category
  {
    'id': 23,
    'name': 'Classic Cheeseburger',
    'description': 'Juicy  patty with melted cheese and fresh vegetables',
    'price': 189,
    'category': 'Burger',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBFCimCM1wFvb3FZQOZH_j5ta4Qd2SlNj2vg&s',
  },
  
  {
    'id': 25,
    'name': 'Veggie Burger',
    'description': 'Grilled vegetable patty with avocado and hummus spread',
    'price': 159,
    'category': 'Burger',
    'imageUrl': 'https://www.inspiredtaste.net/wp-content/uploads/2018/05/Homemade-Mushroom-Veggie-Burger-Recipe-1200.jpg',
  },

  // Pasta Category
  {
    'id': 26,
    'name': 'Spaghetti Carbonara',
    'description': 'Creamy pasta with pancetta and parmesan cheese',
    'price': 249,
    'category': 'Pasta',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_5ZLrsXeFpqV_GkvoebpawtwqBreSGqFjXA&s',
  },
  {
    'id': 27,
    'name': 'Penne Arrabiata',
    'description': 'Spicy tomato sauce with garlic and red chili flakes',
    'price': 219,
    'category': 'Pasta',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_nGDDulThMNxzzgFAl1RZE4YbcytzAjEzcA&s',
  },
  {
    'id': 28,
    'name': 'Lasagna',
    'description': 'Layered pasta with meat sauce and melted cheese',
    'price': 279,
    'category': 'Pasta',
    'imageUrl': 'https://www.eatingwell.com/thmb/g2-SPKemdPybZTIGBKowO3DNOrE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(1965x1419:1967x1421)/Veggie-Lasagna-beauty-557-5cb561c36d4a409dbd587417b8c6682d.jpg',
  },

  // Salad Category
  {
    'id': 29,
    'name': 'Caesar Salad',
    'description': 'Romaine lettuce with croutons and parmesan dressing',
    'price': 199,
    'category': 'Salad',
    'imageUrl': 'https://cdn.loveandlemons.com/wp-content/uploads/2024/12/caesar-salad.jpg',
  },
  {
    'id': 30,
    'name': 'Greek Salad',
    'description': 'Fresh vegetables with feta cheese and olive dressing',
    'price': 179,
    'category': 'Salad',
    'imageUrl': 'https://www.simplyrecipes.com/thmb/0NrKQlJ691l6L9tZXpL06uOuWis=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Easy-Greek-Salad-LEAD-2-4601eff771fd4de38f9722e8cafc897a.jpg',
  },

  // Sides Category
  {
    'id': 31,
    'name': 'French Fries',
    'description': 'Crispy golden potato fries with seasoning',
    'price': 99,
    'category': 'Sides',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8ae8p5fO5SDVCFj-xEWTJaECdaCkzSx0jsA&s',
  },
  {
    'id': 32,
    'name': 'Garlic Bread',
    'description': 'Toasted bread with garlic butter and herbs',
    'price': 89,
    'category': 'Sides',
    'imageUrl': 'https://www.allrecipes.com/thmb/sueXmRXgK-S27uRzTrJuGb-_Smc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/216077-garlic-bread-spread-step-beauty-4x3-BP-3169-ef03a4a12d8c46e196055555be5b8d79.jpg',
  },

  // Drinks Category
  {
    'id': 33,
    'name': 'Fresh Lime Soda',
    'description': 'Refreshing lime drink with mint and soda',
    'price': 59,
    'category': 'Drinks',
    'imageUrl': 'https://www.seriouseats.com/thmb/Lkr5DnY7jNP2aP5DS3d5qE0PEkQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2020__08__20200816-nimbu-soda-vicky-wasik-1-28079d5d45ee4e47a37a969d1e4834a0.jpg',
  },
  {
    'id': 34,
    'name': 'Mango Lassi',
    'description': 'Sweet yogurt-based drink with fresh mango',
    'price': 79,
    'category': 'Drinks',
    'imageUrl': 'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/mango-lassi-recipe.jpg',
  },
  {
    'id': 35,
    'name': 'Iced Tea',
    'description': 'Chilled black tea with lemon and mint',
    'price': 65,
    'category': 'Drinks',
    'imageUrl': 'https://images.themodernproper.com/production/posts/IcedTea_8.jpg?w=960&h=960&q=82&fm=jpg&fit=crop&dm=1716306653&s=e7e37b87126eaafc95ddb53435ba341e',
  }
];
  // Categories
 final List<String> categories = ['All', 'Pizza', 'Burger', 'Pasta', 'Salad', 'Sides', 'Drinks'];
  
  // Get food items by category
  List<Map<String, dynamic>> getFoodItemsByCategory(String category) {
    if (category == 'All') {
      return foodItems;
    }
    return foodItems.where((item) => item['category'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Delivery'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              if (getCartItemCount() > 0)
                Positioned(
                  right: 8,
                  top: 8,
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
                      'Rs{getCartItemCount()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Deepak Yadav',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),  
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Order Tracking'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/order-tracking');
              },
            ),     
          ],
        ),
      ),
      body: Column(
        children: [
          // Category selector
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedCategory == categories[index]
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Food items grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: getFoodItemsByCategory(selectedCategory).length,
              itemBuilder: (ctx, index) {
                final foodItem = getFoodItemsByCategory(selectedCategory)[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/food-detail',
                      arguments: foodItem,
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
  child: Container(
    height: 120,
    width: double.infinity,
    color: Colors.grey[200],
    child: foodItems[index]['imageUrl'] != null
        ? Image.network(
            foodItems[index]['imageUrl'],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.restaurant,
                size: 60,
                color: Colors.grey[400],
              );
            },
          )
        : Icon(
            Icons.restaurant,
            size: 60,
            color: Colors.grey[400],
          ),
  ),
),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                foodItem['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\ Rs ${foodItem['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

