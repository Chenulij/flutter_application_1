class CartItem {
  final int id; // Cart item ID
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.image,
  });

  // Factory to create CartItem from JSON response
  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      productName: product['name'] ?? 'Unknown',
      price: double.tryParse(product['price']?.toString() ?? '0') ?? 0.0,
      quantity: json['quantity'],
      image: 'http://192.168.1.10:8000/uploads/${product['image'] ?? ""}',
    );
  }

  // Convert CartItem to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}