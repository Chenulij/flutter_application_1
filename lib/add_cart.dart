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

    // Show Order Confirmation Message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Confirmed", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700)), 
        content: const Text("Your order has been placed successfully.", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400)), 
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              setState(() {
                widget.cartItems.clear(); 
              });
            },
            child: const Text("OK", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Scaffold(
      backgroundColor: theme.colorScheme.background, 
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w500)), 
        backgroundColor: theme.appBarTheme.backgroundColor, 
        elevation: 0, 
        iconTheme: IconThemeData(color: theme.iconTheme.color), 
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                "Cart is empty!",
                style: TextStyle(
                  fontSize: 18,
                  color: theme.colorScheme.onBackground, 
                  fontFamily: 'Roboto',
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return ListTile(
                  leading: Image.asset(product.image, width: 50, height: 50),
                  title: Text(
                    product.name,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: theme.colorScheme.onBackground, 
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    "LKR. ${product.price}",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: theme.colorScheme.onBackground, 
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: theme.colorScheme.error), 
                    onPressed: () {
                      setState(() {
                        widget.cartItems.removeAt(index); // Remove Product from cart
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: proceedToCheckout, 
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary, 
            foregroundColor: theme.colorScheme.onPrimary, 
          ),
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: theme.colorScheme.onPrimary, 
              fontWeight: FontWeight.w700, 
            ),
          ),
        ),
      ),
    );
  }
}
