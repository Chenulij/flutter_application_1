import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'product_screen.dart';
import 'profile_screen.dart';
import 'add_cart.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? token;

  final List<String> images = [
    'assets/Brown.jpg',
    'assets/Reddy.jpg',
    'assets/Blue.jpg',
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? savedToken = await _storage.read(key: 'auth_token');
    setState(() {
      token = savedToken;
    });
  }

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
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
        onTap: () {},
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
}
