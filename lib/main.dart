import 'package:flutter/material.dart';
import 'login_screen.dart';  

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
      home: const LoginScreen(),  
    );
  }
}
