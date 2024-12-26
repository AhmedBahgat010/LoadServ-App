import 'package:dartz/dartz.dart';
import 'package:loadserv_app/common/base/base_repository.dart';
import 'package:loadserv_app/features/categories/data/datasources/productDetails_datasource.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/ProductDetails_response.dart';
import 'package:loadserv_app/features/categories/domain/repositories/productDetails_repository.dart';
import '../../domain/params/get_productDetails_params.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/common/failure.dart';
@Injectable(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl extends ProductDetailsRepository with BaseRepository {
  final ProductDetailsDatasource dataSource;

  ProductDetailsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails({
    required GetProductDetailsParams params,
  }) async {
         return handleError(() => dataSource.getProductDetails(params: params));


  }
}

