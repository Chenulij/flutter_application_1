import 'package:flutter/material.dart';
import 'login_screen.dart'; 
import 'product.dart'; 
import 'profile.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Carousel Image List
  final List<String> images = [
    'assets/Brown.jpg',
    'assets/Reddy.jpg',
    'assets/Blue.jpg',
  ];
  int currentIndex = 0;

  // Carousel Navigation
  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }

  void prevImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textColor = colorScheme.onBackground; 

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double carouselHeight = screenHeight * 0.35; 

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/logo2.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag, color: textColor),
            onPressed: () {},
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
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            _drawerItem('Product', () => _navigateTo(context, const ProductPage()), textColor),
            _drawerItem('Profile', () => _navigateTo(context, ProfilePage()), textColor),
            _drawerItem('Logout', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), 
              );
            }, textColor),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: carouselHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(images[currentIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  _carouselButton(Icons.arrow_back_ios, prevImage, Alignment.centerLeft),
                  _carouselButton(Icons.arrow_forward_ios, nextImage, Alignment.centerRight),
                ],
              ),
            ),

            // Product Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _productCard('assets/iphone16.jpg', screenWidth, colorScheme),
                  const SizedBox(width: 16),
                  _productCard('assets/ClearCases.jpg', screenWidth, colorScheme),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, VoidCallback onTap, Color textColor) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: textColor),
      ),
      onTap: onTap,
    );
  }

  Widget _carouselButton(IconData icon, VoidCallback onTap, Alignment alignment) {
    return Positioned(
      top: 50,
      left: alignment == Alignment.centerLeft ? 10 : null,
      right: alignment == Alignment.centerRight ? 10 : null,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }

  Widget _productCard(String imagePath, double screenWidth, ColorScheme colorScheme) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
         
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            width: screenWidth * 0.45,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
