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
        title: Text("Order Confirmed", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700)), // Use SemiBold font
        content: Text("Your order has been placed successfully.", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400)), // Use Regular font
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              setState(() {
                widget.cartItems.clear(); // ✅ Clear the cart
              });
            },
            child: Text("OK", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500)), // Medium weight font
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: Text("Your Cart", style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w500)), // Use Medium weight for the title
        backgroundColor: Colors.white, // Set AppBar background to white
        elevation: 0, // Remove the AppBar shadow
        iconTheme: const IconThemeData(color: Colors.black), // Set AppBar icons to black
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text("Cart is empty!", style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Roboto')),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return ListTile(
                  leading: Image.asset(product.image, width: 50, height: 50),
                  title: Text(product.name, style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w400)), // Regular font
                  subtitle: Text("LKR. ${product.price}", style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w400)), // Regular font
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text("Proceed to Checkout", style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w700)), // SemiBold font for button text
        ),
      ),
    );
  }
}
