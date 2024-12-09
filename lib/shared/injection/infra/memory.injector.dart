import 'package:fluttrix/shared/injection/domain/dependency.injector.dart';

class MemoryInjector extends DependencyInjector{
  final Map<Type, dynamic> _container = {};

  @override
  void register<T>(T instance) {
    _container[T] = instance;
  }

  @override
  T resolve<T>() {
    final instance = _container[T];
    if (instance == null) {
      throw Exception('Dependency of type $T not found');
    }
    return instance as T;
  }
}