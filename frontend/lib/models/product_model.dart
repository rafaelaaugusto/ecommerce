class ProductModel {
  final String id;
  final String name;
  final String price;
  final bool hasDiscount;
  final String? discountValue;
  final List<String> gallery;
  final String? description;
  final String? material;
  final String? department;
  final Map<String, dynamic>? details;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.hasDiscount = false,
    this.discountValue,
    this.gallery = const [],
    this.description,
    this.material,
    this.department,
    this.details,
  });
}
