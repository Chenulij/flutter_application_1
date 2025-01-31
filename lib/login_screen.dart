import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage
import 'Signup_screen.dart'; // Import SignUpScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Hardcoded username and password
  final String _hardcodedUsername = 'User';
  final String _hardcodedPassword = 'User123';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
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
      body: OrientationBuilder(
        builder: (context, orientation) {
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
                              'WELCOME BACK !!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onBackground, // Dynamic text color
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: theme.colorScheme.onBackground),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person, color: theme.colorScheme.onBackground),
                              ),
                              style: TextStyle(color: theme.colorScheme.onBackground),
                              validator: (value) => value!.isEmpty ? 'Please enter your username' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: theme.colorScheme.onBackground),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock, color: theme.colorScheme.onBackground),
                              ),
                              style: TextStyle(color: theme.colorScheme.onBackground),
                              validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  if (_usernameController.text == _hardcodedUsername &&
                                      _passwordController.text == _hardcodedPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Login Successful!')),
                                    );
                                    Future.delayed(const Duration(seconds: 2), () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomePage()),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Incorrect username or password!')),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: theme.colorScheme.primary, // Use theme primary color
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                              child: const Text('Login'),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",
                                    style: TextStyle(color: theme.colorScheme.onBackground)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
