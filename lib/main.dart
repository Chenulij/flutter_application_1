import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main_screen.dart'; // Import it so LoginScreen can navigate to it

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
      themeMode: ThemeMode.system,
      home: const LoginScreen(), // App starts with LoginScreen (this is correct)
    );
  }
}
