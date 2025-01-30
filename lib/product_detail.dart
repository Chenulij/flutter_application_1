import 'package:flutter/material.dart';
import 'product.dart';
import 'add_cart.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> cartItems = [];

  // List of all available products for the "Products You May Like" section
  List<Product> allProducts = [
    Product(name: "Cottage", image: "assets/cot.webp", price: 2450),
    Product(name: "Heat Overload", image: "assets/HeatOver.webp", price: 3000),
    Product(name: "Blue Waves", image: "assets/BlueWaves.png", price: 2500),
    Product(name: "Heart Breaker", image: "assets/breaker.jpg", price: 3000),
    Product(name: "Checkered", image: "assets/checkered.webp", price: 3000),
    Product(name: "Teddy", image: "assets/teddy.webp", price: 3000),
    // Add more products as needed
  ];

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item added to cart!")),
    );
  }

  // Function to get description based on product name
  String getDescription(String productName) {
    Map<String, String> descriptions = {
      "Cottage": "A cozy aesthetic case with soft pastel tones.",
      "Heat Overload": "A fiery and bold case for those who love a statement piece.",
      "Blue Waves": "An ocean-inspired case with a soothing wave pattern.",
      "Heart Breaker": "A trendy heart-patterned case for a stylish touch.",
      "Checkered": "A classic checkered design for a retro look.",
      "Teddy": "A soft teddy bear-themed case for ultimate cuteness.",
      // Add descriptions for other products here
    };

    return descriptions[productName] ?? "A stylish and high-quality case designed for durability and aesthetics.";
  }

  @override
  Widget build(BuildContext context) {
    // Filter out the current product from the list of products to avoid showing it in the "Products You May Like" section
    List<Product> suggestedProducts = allProducts.where((p) => p.name != widget.product.name).toList();

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
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCartPage(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.product.image,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black,
                      fontFamily: 'Roboto',  // Apply custom font
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "LKR. ${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',  // Apply custom font
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black,
                      fontFamily: 'Roboto',  // Apply custom font
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getDescription(widget.product.name),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16, 
                      color: Colors.black, 
                      fontFamily: 'Roboto',  // Apply custom font
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addToCart(widget.product);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Add To Cart", 
                          style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),  // Apply custom font
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ "Products You May Like" Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Products You May Like",
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.black,
                        fontFamily: 'Roboto',  // Apply custom font
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: suggestedProducts.length, // Display suggested products
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: suggestedProducts[index], // Show other products
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              // Navigate to product detail page when a product is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Container(
              width: 110,
              height: 140,
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
            style: const TextStyle(
              fontSize: 14, 
              color: Colors.black,
              fontFamily: 'Roboto',  // Apply custom font
            ),
          ),
          Text(
            "LKR. ${product.price}",
            style: const TextStyle(
              fontSize: 12, 
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',  // Apply custom font
            ),
          ),
        ],
      ),
    );
  }
}
