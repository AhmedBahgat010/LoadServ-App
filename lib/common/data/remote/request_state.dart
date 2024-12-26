import 'package:equatable/equatable.dart';

class RequestState<T> extends Equatable {
  final bool isLoading, isSuccess, isError, isPagingLoading;
  final T? data;
  final String? errorMessage;

  const RequestState._({
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
    required this.isPagingLoading,
    required this.data,
    required this.errorMessage,
  });

  factory RequestState.initial() {
    return RequestState._(
      isLoading: false,
      isSuccess: false,
      isError: false,
      isPagingLoading: false,
      data: null,
      errorMessage: null,
    );
  }

  factory RequestState.loading({bool pagingLoading = false}) {
    return RequestState._(
      isLoading: pagingLoading.not(),
      isSuccess: false,
      isError: false,
      isPagingLoading: pagingLoading,
      data: null,
      errorMessage: null,
    );
  }

  factory RequestState.success(T? data) {
    return RequestState._(
      isLoading: false,
      isSuccess: true,
      isError: false,
      isPagingLoading: false,
      data: data,
      errorMessage: null,
    );
  }

  factory RequestState.error(String errorMessage) {
    return RequestState._(
      isLoading: false,
      isSuccess: false,
      isError: true,
      isPagingLoading: false,
      data: null,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, isError, isPagingLoading, data, errorMessage];
}
extension Not on bool {
  bool not() {
    return !this;
  }
}
