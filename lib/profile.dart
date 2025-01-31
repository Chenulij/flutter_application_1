import 'package:flutter/material.dart';
import 'home.dart'; 
import 'product.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final isDarkMode = theme.brightness == Brightness.dark; 
    final textColor = isDarkMode ? Colors.white : Colors.black; 

    return Scaffold(
      backgroundColor: theme.colorScheme.background, 
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface, 
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black), 
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), 
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chenuli Jayasekara',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: textColor), 
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Wattala',
                        style: TextStyle(color: textColor), 
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.cardColor, 
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.2), 
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    ProfileRowItem(label: 'Email', value: 'chenulij@gmail.com'),
                    ProfileRowItem(label: 'Phone', value: '+123456789'),
                    ProfileRowItem(label: 'Member Since', value: 'June 2024'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
             
              ElevatedButton(
                onPressed: () {
                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor, 
                  foregroundColor: theme.colorScheme.onPrimary, 
                ),
                child: Text(
                  'Browse Categories',
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), 
                ),
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
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final isDarkMode = theme.brightness == Brightness.dark; 
    final textColor = isDarkMode ? Colors.white : Colors.black; 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: textColor), 
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: textColor), 
          ),
        ],
      ),
    );
  }
}
