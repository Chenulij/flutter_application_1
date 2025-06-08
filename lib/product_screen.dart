import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/product_service.dart';
import 'product_detail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductScreenWrapper extends StatefulWidget {
  const ProductScreenWrapper({super.key});

  @override
  State<ProductScreenWrapper> createState() => _ProductScreenWrapperState();
}

class _ProductScreenWrapperState extends State<ProductScreenWrapper> {
  String? _token;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    setState(() {
      _token = token;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_token == null) {
      return const Center(child: Text('Not authenticated!'));
    }
    return ProductScreen(token: _token!);
  }
}

class ProductScreen extends StatefulWidget {
  final String token;

  const ProductScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService().fetchProducts(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullImageUrl = product.image;

    // Debug print to verify URL during runtime (remove later if needed)
    print('🖼️ Image URL: $fullImageUrl');

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              fullImageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 60);
              },
            ),
          ),
          title: Text(product.name),
          subtitle: Text(product.category),
          trailing: Text('LKR. ${product.price.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
