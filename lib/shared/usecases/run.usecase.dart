import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/shared/domain/fetcher.dart';

class RunUseCase<T, E> {
  final Future<Either<E, T>> useCase;
  final Fetcher<T>? fetcher;
  final bool _disableLoading;
  final List<Type> ignoreErrors;

  RunUseCase({
    required this.useCase,
    this.fetcher,
    bool disableLoading = false,
    this.ignoreErrors = const [],
  }) : _disableLoading = disableLoading;

  void execute({
    ValueSetter<T>? onSuccess,
    ValueSetter<E>? onError,
    VoidCallback? onFinally,
    VoidCallback? onBefore,
  }) {
    onBefore?.call();
    if (!_disableLoading) {
      fetcher?.setLoading();
    }
    useCase.then((response) {
      onFinally?.call();
      fetcher?.reset();
      response.fold(
            (err) {
          if (ignoreErrors.contains(err.runtimeType)) {
            return;
          }
          fetcher?.setError();
          onError?.call(err);
        },
            (result) {
          fetcher?.value = result;
          onSuccess?.call(result);
        },
      );
    }).catchError((Object e) {
      onFinally?.call();
      fetcher?.setError();
    });
  }
}