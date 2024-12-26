import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:loadserv_app/common/failure.dart';

import '../data/remote/api_basehelper.dart';

mixin BaseRepository {
  Future<Either<Failure, T>> handleError<T>(
      Future<T> Function() dataSourceFunction,
      {Function? onSuccess}) async {
    try {
      final T response = await dataSourceFunction();
      if (onSuccess != null) {
        await onSuccess();
      }
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on SocketException {
      return Left(ServerFailure(message: tr('server_error')));
    } catch (e) {
      return Left(ServerFailure(message: tr('error')));
    }
  }
}
