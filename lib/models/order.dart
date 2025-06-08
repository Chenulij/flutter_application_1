class Order {
  final int id;
  final double total;
  final String address;
  // Add more fields as needed

  Order({required this.id, required this.total, required this.address});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'] ?? json['id'],
      total: (json['total'] is int)
          ? (json['total'] as int).toDouble()
          : (json['total'] ?? 0.0),
      address: json['address'] ?? '',
    );
  }
}
