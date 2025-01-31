import 'package:flutter/material.dart';
import 'home.dart'; 
import 'login_screen.dart'; 

class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String _hardcodedEmail = 'user@gmail.com';
  final String _hardcodedUsername = 'User';
  final String _hardcodedPassword = 'User123';

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Scaffold(
      backgroundColor: theme.colorScheme.background, 
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, 
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo2.png', height: 30), 
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Expanded(
                child: Center( 
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.textTheme.titleLarge?.color, 
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), 
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email, color: theme.iconTheme.color),
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), 
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person, color: theme.iconTheme.color), 
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), 
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), 
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color), 
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), 
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color), 
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color), 
                              ),
                              style: TextStyle(color: theme.textTheme.bodyLarge?.color), 
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
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  if (_emailController.text == _hardcodedEmail &&
                                      _usernameController.text == _hardcodedUsername &&
                                      _passwordController.text == _hardcodedPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Registration Successful!')),
                                    );
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
                                backgroundColor: theme.brightness == Brightness.dark
                                    ? Colors.white
                                    : theme.primaryColor,
                                foregroundColor: theme.brightness == Brightness.dark
                                    ? Colors.black
                                    : theme.colorScheme.onPrimary,
                              ),
                              child: const Text('Register'),
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 30), 
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
