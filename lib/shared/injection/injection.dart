class Injection {
  static final Map<Type, dynamic> _container = {};

  static void register<T>(T instance) {
    _container[T] = instance;
  }

  static T resolve<T>() {
    final instance = _container[T];
    if (instance == null) {
      throw Exception('Dependency of type $T not found');
    }
    return instance as T;
  }
}
