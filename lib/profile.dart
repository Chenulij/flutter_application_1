import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage
import 'product.dart'; // Import ProductPage

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for AppBar
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black), // Black text color
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView for scrollable content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture and Info
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Dummy image
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jane Doe',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Black font color
                      ),
                      SizedBox(height: 4),
                      Text(
                        'San Francisco, CA',
                        style: TextStyle(color: Colors.black54), // Lighter black color for secondary text
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              // Card Section with categories
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    ProfileRowItem(label: 'Email', value: 'janedoe@email.com'),
                    ProfileRowItem(label: 'Phone', value: '+123456789'),
                    ProfileRowItem(label: 'Member Since', value: 'March 2022'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Category Navigation
              ElevatedButton(
                onPressed: () {
                  // Navigate to HomePage to show categories
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: const Text('Browse Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileRowItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRowItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54), // Lighter black color
          ),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black), // Black font color
          ),
        ],
      ),
    );
  }
}
