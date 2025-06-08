// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = 'http://192.168.1.10:8000/api'; // adjust if needed

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Helper method to get headers
  Future<Map<String, String>> _getHeaders({bool includeAuth = false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // LOGIN method
  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/customer/login');
      final headers = await _getHeaders();

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        
        if (token != null) {
          await _storage.write(key: 'auth_token', value: token);
          return true;
        }
      }
      
      print('Login failed: ${response.body}');
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // REGISTER method
  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    try {
      final url = Uri.parse('$baseUrl/customer/register');
      final headers = await _getHeaders();

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      print('Registration response: ${response.body}'); // Debug print

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        
        if (token != null) {
          await _storage.write(key: 'auth_token', value: token);
          return true;
        }
      }
      
      print('Registration failed: ${response.body}');
      return false;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // LOGOUT method
  Future<void> logout() async {
    try {
      final url = Uri.parse('$baseUrl/logout');
      final headers = await _getHeaders(includeAuth: true);

      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        await _storage.delete(key: 'auth_token');
      } else {
        print('Logout failed: ${response.body}');
      }
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return null;

      final url = Uri.parse('$baseUrl/user');
      final headers = await _getHeaders(includeAuth: true);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data, token);
      }
      
      return null;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }
}
