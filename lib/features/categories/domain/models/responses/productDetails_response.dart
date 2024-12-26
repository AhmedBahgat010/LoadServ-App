
import 'package:loadserv_app/features/categories/domain/models/product.dart';

class ProductDetailsResponse {
  final ProductData data;
  final String message;

  ProductDetailsResponse({
    required this.data,
    required this.message,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>ProductDetailsResponse(
    data: ProductData.fromJson(json["data"]),
    message: json["message"],
  );

}




