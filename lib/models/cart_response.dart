import 'cart_item.dart';

class CartResponse {
  final List<CartItem> items;
  final double total;

  CartResponse({required this.items, required this.total});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
