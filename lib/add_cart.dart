import 'package:flutter/material.dart';
import 'product.dart';

class AddCartPage extends StatefulWidget {
  final List<Product> cartItems;

  const AddCartPage({super.key, required this.cartItems});

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  void proceedToCheckout() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty! Add items first.")),
      );
      return;
    }

    // ✅ Show Order Confirmation Message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Confirmed "),
        content: const Text("Your order has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              setState(() {
                widget.cartItems.clear(); // ✅ Clear the cart
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
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text("Cart is empty!", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return ListTile(
                  leading: Image.asset(product.image, width: 50, height: 50),
                  title: Text(product.name),
                  subtitle: Text("LKR. ${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.cartItems.removeAt(index); // Remove item from cart
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: proceedToCheckout, // ✅ Calls the function to show message
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text("Proceed to Checkout", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
