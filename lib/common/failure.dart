import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object> get props => <Object>[];
}

class ServerFailure extends Failure {
  final int? code;

  const ServerFailure({
    super.message,
    this.code,
  });
}

class CacheFailure extends Failure {}

class FirebaseFailure extends Failure {
  FirebaseFailure({super.message});
}
