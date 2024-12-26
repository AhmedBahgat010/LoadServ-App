
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/features/categories/domain/params/get_categories_params.dart';

import '../../../../common/data/remote/api_basehelper.dart';
import '../../domain/models/responses/Categories_response.dart';

final String categoriesEndPoint = '/singleCategory/';

abstract class CategoriesDatasource {
  Future<CategoriesResponse> getCategories({required GetCategoriesParams params});
}

@Injectable(as : CategoriesDatasource)
class CategoriesDatasourceImpl extends CategoriesDatasource{
  final ApiBaseHelper helper;
  CategoriesDatasourceImpl({required this.helper});

  @override
  Future<CategoriesResponse> getCategories({required GetCategoriesParams params}) async{
    final response = await helper.get(url: '$categoriesEndPoint ${params.id}');
    return CategoriesResponse.fromJson(response);
  }

}