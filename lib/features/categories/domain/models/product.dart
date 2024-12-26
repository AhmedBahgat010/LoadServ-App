class ProductData {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool isSingle;
  final int points;
  final int price;
  final int priceBeforeDiscount;
  final List<ExtraItem> extraItems;
  final List<Salad> salads;
  final List<Weight>? weights;
  int quantity; // Added quantity to handle cart logic

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.points,
    required this.price,
    required this.priceBeforeDiscount,
    required this.extraItems,
    required this.salads,
    required this.weights,
    this.quantity = 1, 
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isSingle: json['is_single'],
      points: json['points'],
      price: json['price'] ?? 0,
      priceBeforeDiscount: json['price_before_discount'] ?? 0,
      extraItems: (json['extra_items'] as List)
          .map((e) => ExtraItem.fromJson(e))
          .toList(),
      salads: (json['salads'] as List).map((e) => Salad.fromJson(e)).toList(),
      weights: json['weights'] == null
          ? null
          : (json['weights'] as List).map((e) => Weight.fromJson(e)).toList(),
      quantity: json['quantity'] ?? 1, // Parse quantity if available
    );
  }
}


class ExtraItem {
  final int id;
  final String name;
  final int price;

  ExtraItem({required this.id, required this.name, required this.price});

  factory ExtraItem.fromJson(Map<String, dynamic> json) {
    return ExtraItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}

class Salad {
  final int id;
  final String name;
  final int price;
  final String image;
  final int? count;

  Salad({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
     this.count =0,
  });

  factory Salad.fromJson(Map<String, dynamic> json) {
    return Salad(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class Weight {
  final int id;
  final String name;
  final int price;
  final int points;
  final int priceBeforeDiscount;
  final int numberOfSalad;

  Weight({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      points: json['points'],
      priceBeforeDiscount: json['price_before_discount'],
      numberOfSalad: json['number_of_salad'],
    );
  }
}
