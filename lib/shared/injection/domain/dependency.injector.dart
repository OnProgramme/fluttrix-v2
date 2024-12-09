abstract class DependencyInjector {
  T resolve<T>();
  void register<T>(T instance);
}