import 'package:dartz/dartz.dart';
import 'package:loadserv_app/common/failure.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/Categories_response.dart';
import 'package:loadserv_app/features/categories/domain/params/get_categories_params.dart';



abstract class CategoriesRepository {
  Future<Either<Failure, CategoriesResponse>> getCategories(
      {required GetCategoriesParams params});
}
