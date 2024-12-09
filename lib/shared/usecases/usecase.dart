import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class UseCase<Return, Command> extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;

  Future<Either<AppFailure, Return>> execute(Command command);

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
        notifyListeners();
        return Right(result);
      });
    });
  }

  bool get isPending => _isLoading;
  bool get isFailed => _isLoading;
}
