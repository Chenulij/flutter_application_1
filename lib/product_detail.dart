  import 'package:flutter/material.dart';
  import 'models/product.dart';
  import 'wishlist.dart';
  import 'add_cart.dart';
  import 'services/CartService.dart'; // <-- Make sure this file exists

  class ProductDetail extends StatelessWidget {
    final Product product;

    const ProductDetail({Key? key, required this.product}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final colorScheme = Theme.of(context).colorScheme;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: colorScheme.onBackground,
            onPressed: () => Navigator.pop(context),
          ),
          title: Image.asset(
            'assets/logo2.png',
            height: 40,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              color: colorScheme.onBackground,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCartPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              product.image,
                              height: 220,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 120),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'LKR. ${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Phone Model:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: 'iPhone 14 Max',
                          items: const [
                            DropdownMenuItem(value: 'iPhone 14 Max', child: Text('iPhone 14 Max')),
                            DropdownMenuItem(value: 'iPhone 13', child: Text('iPhone 13')),
                            DropdownMenuItem(value: 'iPhone 12', child: Text('iPhone 12')),
                          ],
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Quantity:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: '1',
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final success = await CartService().addToCart(productId: product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success
                                      ? 'Added to cart!'
                                      : 'Failed to add to cart.'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
