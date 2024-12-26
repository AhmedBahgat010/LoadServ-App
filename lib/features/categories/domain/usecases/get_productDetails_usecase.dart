

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/features/categories/domain/repositories/productDetails_repository.dart';

import '../../../../common/base/usecase.dart';
import '../../../../common/failure.dart';
import '../models/responses/ProductDetails_response.dart';
import '../params/get_productDetails_params.dart';

@Injectable()
class GetProductDetailsUseCase
    extends UseCase<ProductDetailsResponse, GetProductDetailsParams> {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsResponse>> call(
      GetProductDetailsParams params) {
    return repository.getProductDetails(params: params);
  }
}
