import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/common/data/remote/request_state.dart';
import 'package:loadserv_app/common/failure.dart';
import 'package:loadserv_app/features/categories/domain/models/responses/Categories_response.dart';
import 'package:loadserv_app/features/categories/domain/params/get_categories_params.dart';
import 'package:loadserv_app/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/categories_state.dart';


// Part file for state

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit(this.getCategoriesUseCase) : super(CategoriesState.initial());

  Future<void> fetchCategories(int id) async {
    emit(state.copyWith(categoriesState: RequestState.loading()));

    final Either<Failure, CategoriesResponse> result =
    await getCategoriesUseCase.call(GetCategoriesParams(id: id) );

    result.fold(
          (failure) => emit(state.copyWith(
          categoriesState: RequestState.error(  failure.message.toString()))),

          (categoriesResponse) => emit(state.copyWith(

          categoriesState: RequestState.success(categoriesResponse.data  ) )),
    );
  }
  
}
