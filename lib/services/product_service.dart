import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts(String token) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.10:8000/api/customer/products'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    // DEBUG: print full response body
    print('API response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      // DEBUG: print image field of first product (if any)
      if (data.isNotEmpty) {
        print('First product image field: ${data[0]['image']}');
      }

      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
