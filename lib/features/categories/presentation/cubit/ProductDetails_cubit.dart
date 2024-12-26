import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/common/failure.dart';
import '../../domain/models/responses/ProductDetails_response.dart';
import '../../domain/params/get_productDetails_params.dart';
import 'package:loadserv_app/common/data/remote/request_state.dart';
import 'package:loadserv_app/features/categories/domain/usecases/get_productDetails_usecase.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/ProductDetails_state.dart';

// Part file for state

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase)
      : super(ProductDetailsState.initial());

  Future<void> fetchProductDetails(int id) async {
    emit(state.copyWith(productDetailsState: RequestState.loading()));

    final Either<Failure, ProductDetailsResponse> result =
        await getProductDetailsUseCase.call(GetProductDetailsParams(id: id));

    result.fold(
      (failure) => emit(state.copyWith(
          productDetailsState: RequestState.error(failure.message.toString()))),
      (ProductDetailsResponse) => emit(state.copyWith(
          productDetailsState:
              RequestState.success(ProductDetailsResponse.data))),
    );
  }
}
