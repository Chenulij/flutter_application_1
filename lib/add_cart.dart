import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/CartService.dart';
import 'models/cart_item.dart';
import 'models/cart_response.dart';
import 'checkout_page.dart';

class AddCartPage extends StatefulWidget {
  final List<Product>? cartItems; // in-memory cartItems (optional)

  const AddCartPage({super.key, this.cartItems});

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  CartResponse? _cartResponse;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.cartItems == null) {
      _loadCart();
    } else {
      _isLoading = false;
    }
  }

  Future<void> _loadCart() async {
    try {
      final response = await CartService().fetchCartResponse();
      setState(() {
        _cartResponse = response;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching cart: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void proceedToCheckout() {
    final isEmpty = widget.cartItems != null
        ? widget.cartItems!.isEmpty
        : (_cartResponse == null || _cartResponse!.items.isEmpty);

    if (isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty! Add items first.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Confirmed"),
        content: const Text("Your order has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                if (widget.cartItems != null) {
                  widget.cartItems!.clear();
                } else {
                  _cartResponse = CartResponse(items: [], total: 0.0);
                }
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCartList(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            // Prepare cart items for checkout
            final cartItems = _cartResponse!.items.map((item) => {
              "product_id": item.productId,
              "quantity": item.quantity,
            }).toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(
                  cartItems: cartItems,
                  total: _cartResponse!.total,
                ),
              ),
            );
          },
          child: const Text("Proceed to Checkout"),
        ),
      ),
    );
  }

  Widget _buildCartList() {
    if (widget.cartItems != null) {
      // In-memory Product list
      if (widget.cartItems!.isEmpty) {
        return const Center(child: Text("Cart is empty!", style: TextStyle(fontSize: 18)));
      }

      return ListView.builder(
        itemCount: widget.cartItems!.length,
        itemBuilder: (context, index) {
          final product = widget.cartItems![index];
          return ListTile(
            leading: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40),
            ),
            title: Text(product.name),
            subtitle: Text("LKR. ${product.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  widget.cartItems!.removeAt(index);
                });
              },
            ),
          );
        },
      );
    } else {
      // CartService-based cart
      if (_cartResponse == null || _cartResponse!.items.isEmpty) {
        return const Center(child: Text("Cart is empty!", style: TextStyle(fontSize: 18)));
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartResponse!.items.length,
              itemBuilder: (context, index) {
                final item = _cartResponse!.items[index];
                return ListTile(
                  leading: Image.network(
                    item.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.productName),
                  subtitle: Text("LKR. ${item.price} x ${item.quantity}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      try {
                        await CartService().removeFromCart(item.id);
                        await _loadCart(); // Reload after delete
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error removing item: $e')),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          // Show total price
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total: LKR. ${_cartResponse!.total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }
}
