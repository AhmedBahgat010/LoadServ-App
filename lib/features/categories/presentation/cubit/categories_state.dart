import 'package:equatable/equatable.dart';
import 'package:loadserv_app/features/categories/domain/models/category.dart';

import '../../../../common/data/remote/request_state.dart';

class CategoriesState extends Equatable {
  final RequestState<Category> categoriesState;

  CategoriesState.initial() : categoriesState = RequestState.initial();

  const CategoriesState({required this.categoriesState});

  CategoriesState copyWith({
    RequestState<Category>? categoriesState,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
    );
  }

  @override
  List<Object?> get props => [categoriesState];
}
