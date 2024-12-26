import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/common/base/base_repository.dart';
import 'package:loadserv_app/common/failure.dart';
import 'package:loadserv_app/features/categories/data/datasources/categories_datasource.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/Categories_response.dart';
import 'package:loadserv_app/features/categories/domain/params/get_categories_params.dart';

import '../../domain/repositories/categories_repository.dart';
@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl extends CategoriesRepository with BaseRepository {
  final CategoriesDatasource dataSource;

  CategoriesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CategoriesResponse>> getCategories(

      {required GetCategoriesParams params}) {
    return handleError(() => dataSource.getCategories(params: params));
  }
}
