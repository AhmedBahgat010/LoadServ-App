import 'package:equatable/equatable.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';

import '../../../../common/data/remote/request_state.dart';

class ProductDetailsState extends Equatable {
  final RequestState<ProductData> productDetailsState;

 ProductDetailsState.initial() : productDetailsState = RequestState.initial();

  const ProductDetailsState({required this.productDetailsState});

 ProductDetailsState copyWith({
    RequestState<ProductData>? productDetailsState,
  }) {
    return ProductDetailsState(
      productDetailsState: productDetailsState ?? this.productDetailsState,
    );
  }

  @override
  List<Object?> get props => [productDetailsState];
}
