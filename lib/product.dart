import 'package:flutter/material.dart';
import 'package:flutter_application_1/product_detail.dart';
import 'add_cart.dart';
import 'login_screen.dart'; // Import Login page
import 'home.dart'; // Import the actual Home page (adjust path if necessary)
import 'profile.dart'; // Import ProfilePage

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(int index) {
    double offset = 0;
    switch (index) {
      case 0:
        offset = 0;
        break;
      case 1:
        offset = 350;
        break;
      case 2:
        offset = 700;
        break;
      case 3:
        offset = 1050;
        break;
      case 4:
        offset = 1400;
        break;
      default:
        offset = 0;
    }
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(238, 238, 238, 238),
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/logo2.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCartPage(cartItems: []),
                ),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  'Categories',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              title: const Text('Phone Cases'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(0);
              },
            ),
            ListTile(
              title: const Text('Tablet Cases'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(1);
              },
            ),
            ListTile(
              title: const Text('Laptop Cases'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(2);
              },
            ),
            ListTile(
              title: const Text('AirPod Cases'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(3);
              },
            ),
            ListTile(
              title: const Text('Accessories'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(4);
              },
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to Home page
                );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProfilePage()), // Navigate to Profile page
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ProductSection(title: "Phone Cases", products: phoneCases),
            ProductSection(title: "Tablet Cases", products: tabletCases),
            ProductSection(title: "Laptop Cases", products: laptopCases),
            ProductSection(title: "AirPod Cases", products: airpodCases),
            ProductSection(title: "Accessories", products: accessories),
          ],
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const ProductSection({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            "LKR. ${product.price}",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String image;
  final int price;

  Product({required this.name, required this.image, required this.price});
}

final List<Product> phoneCases = [
  Product(name: "Cottage", image: "assets/iphone1.jpg", price: 2000),
  Product(name: "Heat Overload", image: "assets/HeatOver.webp", price: 2000),
  Product(name: "Blue Waves", image: "assets/BlueWaves.png", price: 2500),
  Product(name: "Heart Breaker", image: "assets/Red.jpg", price: 2000),
];

final List<Product> tabletCases = [
  Product(name: "Cottage", image: "assets/cottab.jpg", price: 3000),
  Product(name: "Checkered", image: "assets/Checkered.webp", price: 3000),
  Product(name: "Teddy", image: "assets/teddy.webp", price: 3000),
  Product(name: "Heart Breaker", image: "assets/breaker.jpg", price: 3000),
];

final List<Product> laptopCases = [
  Product(name: "Cottage", image: "assets/cottlap.webp", price: 3000),
  Product(name: "Cherry Blast", image: "assets/cherryBlast.webp", price: 3000),
  Product(name: "Siren Flower", image: "assets/siren.jpg", price: 3000),
  Product(name: "Candy Love", image: "assets/candy.webp", price: 3000),
];

final List<Product> airpodCases = [
  Product(name: "Cottage", image: "assets/cot.webp", price: 2450),
  Product(name: "Cherry Blast", image: "assets/burndey.webp", price: 2450),
  Product(name: "Star Blue", image: "assets/Cherry.webp", price: 2450),
  Product(name: "Seashell", image: "assets/sea.webp", price: 2450),
];

final List<Product> accessories = [
  Product(name: "Cottage Ring Holder", image: "assets/pop.webp", price: 1750),
  Product(name: "Snowy Charm", image: "assets/snowy.webp", price: 4000),
  Product(name: "Friends Watch", image: "assets/friends.png", price: 3500),
];
