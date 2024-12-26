class Category {
  final int id;
  final String name;
  final String backgroundImage;
  final String image;
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.image,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      image: json['image'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool isSingle;
  final double price;
  final double priceBeforeDiscount;
  final int points;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.price,
    required this.priceBeforeDiscount,
    required this.points,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isSingle: json['is_single'],
      price: (json['price'] as num).toDouble(),
      priceBeforeDiscount: (json['price_before_discount'] as num).toDouble(),
      points: json['points'],
    );
  }
}
