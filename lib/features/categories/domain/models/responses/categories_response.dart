
import '../../../../../common/data/meta.dart';
import '../category.dart';

class CategoriesResponse {
  final Category data;
  final String message;

  CategoriesResponse({
    required this.data,
    // required this.meta,
    required this.message,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
    data: Category.fromJson(json["data"]),
    message: json["message"],
  );

}




