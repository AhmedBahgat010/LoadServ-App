
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/features/categories/domain/params/get_productDetails_params.dart';

import '../../../../common/data/remote/api_basehelper.dart';
import '../../domain/models/responses/ProductDetails_response.dart';

final String ProductDetailsEndPoint = '/productDetails/';

abstract class ProductDetailsDatasource {
  Future<ProductDetailsResponse> getProductDetails({required GetProductDetailsParams params});
}

@Injectable(as : ProductDetailsDatasource)
class ProductDetailsDatasourceImpl extends ProductDetailsDatasource{
  final ApiBaseHelper helper;
  ProductDetailsDatasourceImpl({required this.helper});

  @override
  Future<ProductDetailsResponse> getProductDetails({required GetProductDetailsParams params}) async{
    final response = await helper.get(url: '$ProductDetailsEndPoint ${params.id}');
    return ProductDetailsResponse.fromJson(response);
  }

}