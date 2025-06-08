import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/cart_item.dart';
import '../models/cart_response.dart';


class CartService {
  final _storage = const FlutterSecureStorage();
  final String baseUrl = 'http://192.168.1.10:8000/api'; // Update your local IP if needed

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Add product to cart
  Future<bool> addToCart({required int productId, int quantity = 1}) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/cart/$productId');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'quantity': quantity}),
    );

    return response.statusCode == 200;
  }

  // Fetch cart items
  Future<List<CartItem>> fetchCart() async {
    final token = await _getToken();
    if (token == null) return [];

    final url = Uri.parse('$baseUrl/cart');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['items']; // updated key
        return data.map((item) => CartItem.fromJson(item)).toList();
      } catch (e) {
        print("Error parsing cart: $e");
        return [];
      }
    } else {
      return [];
    }
  }

  // Remove item from cart by cart item ID
  Future<bool> removeFromCart(int cartItemId) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/cart/$cartItemId');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return response.statusCode == 200;
  }

  Future<CartResponse?> fetchCartResponse() async {
  final token = await _getToken();
  if (token == null) return null;

  final url = Uri.parse('$baseUrl/cart');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    try {
      final decoded = jsonDecode(response.body);
      return CartResponse.fromJson(decoded);
    } catch (e) {
      print("Error parsing cart: $e");
      return null;
    }
  } else {
    return null;
  }
}

}
