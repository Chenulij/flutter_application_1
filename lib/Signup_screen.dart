import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import LoginScreen to navigate back
import 'home.dart'; // Import HomePage widget

class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Hardcoded sign-up details
  final String _hardcodedEmail = 'user@gmail.com';
  final String _hardcodedUsername = 'User';
  final String _hardcodedPassword = 'User123';

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      backgroundColor: theme.colorScheme.background, // Use background color from the theme
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, // AppBar background color based on theme
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo2.png', height: 30), // Add logo here
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust layout based on orientation
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Keeps footer at bottom
            children: [
              Expanded(
                child: Center( // ✅ Centers the form vertically
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                          children: [
                            // WELCOME BACK message
                            Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.textTheme.titleLarge?.color, // Title text color based on theme
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), // Label text color based on theme
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email, color: theme.iconTheme.color), // Icon color based on theme
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), // Text input color based on theme
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Username Field
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), // Label color based on theme
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person, color: theme.iconTheme.color), // Icon color based on theme
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), // Input text color based on theme
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), // Label color based on theme
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color), // Icon color based on theme
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), // Input text color based on theme
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), // Label color based on theme
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color), // Icon color based on theme
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), // Input text color based on theme
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Sign Up Button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  // Check if the entered details match the hardcoded values
                                  if (_emailController.text == _hardcodedEmail &&
                                      _usernameController.text == _hardcodedUsername &&
                                      _passwordController.text == _hardcodedPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Registration Successful!')),
                                    );
                                    // After successful registration, navigate to HomeScreen
                                    Future.delayed(const Duration(seconds: 2), () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomePage()),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Incorrect details!')),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: theme.primaryColor, // Button color based on theme
                                foregroundColor: theme.colorScheme.onPrimary, // Text color on button
                              ),
                              child: const Text('Register'),
                            ),
                            const SizedBox(height: 20),

                            // Already have an account? Redirect to login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? ", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Log in here',
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30), // Extra space before footer
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
