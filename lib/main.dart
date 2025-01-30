import 'package:flutter/material.dart';
import 'login_screen.dart';  // Import the LoginScreen widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Techtify',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.grey.shade900),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(primary: Colors.grey.shade300),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // Automatically follow system theme
      home: const LoginScreen(),  // Start with the LoginScreen
    );
  }
}
