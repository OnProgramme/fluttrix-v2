import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class UseCase<Return> extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  Return? data;
  final _stream = StreamController<Return>.broadcast();

  @protected
  Future<Either<AppFailure, Return>> call(
      Future<Either<AppFailure, Return>> execute) async {
    _isError = false;
    _isLoading = true;
    notifyListeners();
    return execute.then((response) {
      _isLoading = false;
      return response.fold((err) {
        _isError = true;
        notifyListeners();
        return Left(err);
      }, (result) {
        data = result;
        _stream.sink.add(result);
        notifyListeners();
        return Right(result);
      });
    });
  }

  bool get isPending => _isLoading;
  bool get isFailed => _isError;

  Stream<Return> get stream => _stream.stream;
}

abstract class UseCaseWithCommand<Return, Command> extends UseCase<Return> {
  Future<Either<AppFailure, Return>> execute(Command command);
}

abstract class UseCaseWithoutCommand<Return> extends UseCase<Return> {
  Future<Either<AppFailure, Return>> execute();
}
