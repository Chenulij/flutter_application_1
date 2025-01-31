import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'add_cart.dart';
import 'login_screen.dart';
import 'home.dart';
import 'profile.dart';

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
      case 0: offset = 0; break;
      case 1: offset = 350; break;
      case 2: offset = 700; break;
      case 3: offset = 1050; break;
      case 4: offset = 1400; break;
      default: offset = 0;
    }
    _scrollController.animateTo(
      offset, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textColor = colorScheme.onBackground;

    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo2.png', height: 40),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCartPage(cartItems: [])),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: textColor),
      ),
      drawer: Drawer(
        backgroundColor: colorScheme.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: colorScheme.surface),
              child: Center(
                child: Text('Categories', style: TextStyle(color: textColor, fontSize: 20)),
              ),
            ),
            _drawerItem('Phone Cases', () => _scrollToSection(0), textColor),
            _drawerItem('Tablet Cases', () => _scrollToSection(1), textColor),
            _drawerItem('Laptop Cases', () => _scrollToSection(2), textColor),
            _drawerItem('AirPod Cases', () => _scrollToSection(3), textColor),
            _drawerItem('Accessories', () => _scrollToSection(4), textColor),
            _drawerItem('Home', () => _navigateTo(context, const HomePage()), textColor),
            _drawerItem('Profile', () => _navigateTo(context, ProfilePage()), textColor),
            _drawerItem('Logout', () => _navigateTo(context, const LoginScreen()), textColor),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ProductSection(title: "Phone Cases", products: phoneCases, orientation: orientation),
            ProductSection(title: "Tablet Cases", products: tabletCases, orientation: orientation),
            ProductSection(title: "Laptop Cases", products: laptopCases, orientation: orientation),
            ProductSection(title: "AirPod Cases", products: airpodCases, orientation: orientation),
            ProductSection(title: "Accessories", products: accessories, orientation: orientation),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, VoidCallback onTap, Color textColor) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: textColor)),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final Orientation orientation;

  const ProductSection({super.key, required this.title, required this.products, required this.orientation});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        SizedBox(
          height: orientation == Orientation.portrait ? 170 : 250,
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
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(opacity: animation, child: ProductDetailPage(product: product));
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(product.image), fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(product.name, style: TextStyle(fontSize: 14, color: textColor)),
          Text(
            "LKR. ${product.price}",
            style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.bold),
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
  Product(name: "Snowy Charm", image: "assets/snowy.webp", price: 1150),
  Product(name: "Friends Watch Strap", image: "assets/friends.jpg", price: 950),
  Product(name: "Sticky Grip", image: "assets/stickygrip.webp", price: 1150),
];
