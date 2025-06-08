class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  String rawImage = json['image'] ?? '';
  String fullImageUrl;

  if (rawImage.startsWith('http')) {
    fullImageUrl = rawImage;
  } else {
    // Normalize to avoid "//images" issue
    fullImageUrl = 'http://192.168.1.10:8000/${rawImage.replaceFirst(RegExp(r'^/'), '')}';
  }

  return Product(
    id: json['id'],
    name: json['name'],
    price: double.tryParse(json['price'].toString()) ?? 0.0,
    image: fullImageUrl,
    category: json['category'] ?? '',
    description: json['description'] ?? '',
  );
}

}