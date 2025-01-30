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

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item added to cart!")),
    );
  }

  // ✅ Function to get description based on product name
  String getDescription(String productName) {
    Map<String, String> descriptions = {
      "Cottage": "A cozy aesthetic case with soft pastel tones.",
      "Heat Overload": "A fiery and bold case for those who love a statement piece.",
      "Blue Waves": "An ocean-inspired case with a soothing wave pattern.",
      "Heart Breaker": "A trendy heart-patterned case for a stylish touch.",
      "Checkered": "A classic checkered design for a retro look.",
      "Teddy": "A soft teddy bear-themed case for ultimate cuteness.",
      "Cherry Blast": "A vibrant cherry-themed case, perfect for bold personalities.",
      "Siren Flower": "An elegant floral design inspired by nature.",
      "Candy Love": "A sweet and colorful case with candy-like patterns.",
      "Star Blue": "A galaxy-themed case for space lovers.",
      "Seashell": "A beach-inspired case with seashell imprints.",
      "Snowy Charm": "A winter-themed case with delicate snowflakes.",
      "Friends Watch Strap": "A stylish and comfortable watch strap for everyday use.",
      "Pink Sticky Grip": "A handy and stylish sticky grip for better phone handling."
    };

    return descriptions[productName] ?? "A stylish and high-quality case designed for durability and aesthetics.";
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
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
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
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "LKR. ${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Display the product description
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getDescription(widget.product.name), // ✅ Get description dynamically
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addToCart(widget.product);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text("Add To Cart", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
