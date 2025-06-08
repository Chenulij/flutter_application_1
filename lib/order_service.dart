import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderService {
  final String baseUrl = 'http://192.168.1.10:8000/api';
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<Map<String, dynamic>?> placeOrder(Map<String, dynamic> orderData) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(orderData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<bool> clearCart() async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response.statusCode == 200;
  }
}
