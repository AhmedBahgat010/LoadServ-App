

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/common/base/usecase.dart';
import 'package:loadserv_app/common/failure.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/Categories_response.dart';
import 'package:loadserv_app/features/categories/domain/params/get_categories_params.dart';
import 'package:loadserv_app/features/categories/domain/repositories/categories_repository.dart';

@Injectable()
class GetCategoriesUseCase
    extends UseCase<CategoriesResponse, GetCategoriesParams> {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, CategoriesResponse>> call(
      GetCategoriesParams params) {
    return repository.getCategories(params: params);
  }
}
