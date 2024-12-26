import 'package:dartz/dartz.dart';
import 'package:loadserv_app/common/failure.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/ProductDetails_response.dart';
import 'package:loadserv_app/features/categories/domain/params/get_productDetails_params.dart';


abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails(
      {required GetProductDetailsParams params});
}

