import 'package:flutter/material.dart';
import 'product.dart'; // Importing the ProductPage

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

  // Scroll Controller for drawer navigation
  final ScrollController _scrollController = ScrollController();

  // Function to scroll to a specific section
  void _scrollToSection(int index) {
    double offset = 0;
    for (int i = 0; i < index; i++) {
      offset += 200; // Adjust the offset based on your section height
    }
    _scrollController.animateTo(offset, duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double carouselHeight = screenHeight * 0.4; // 40% of the screen height

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
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black), // Changing hamburger icon color to black
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
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()), // Navigate to ProductPage
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Handle logout functionality here
                // For example, navigate to login screen or clear user session
                Navigator.pop(context); // Close the drawer
                // You can implement your logout logic here
                print("Logged out");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Carousel
          Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjusting the top padding
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
                Positioned(
                  top: carouselHeight / 2 - 20,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: prevImage,
                  ),
                ),
                Positioned(
                  top: carouselHeight / 2 - 20,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: nextImage,
                  ),
                ),
              ],
            ),
          ),

          // Product Section (Side by Side)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Product 1
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the product detail page
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/iphone16.jpg',
                        width: screenWidth * 0.4, // Responsive width
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between images

                // Product 2
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the product detail page
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/ClearCases.jpg',
                        width: screenWidth * 0.4, // Responsive width
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Spacer to push the footer to the bottom
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.tiktok, size: 30, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.facebook, size: 30, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 30, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            "© 2024 Techify. All rights reserved.",
            style: TextStyle(fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
