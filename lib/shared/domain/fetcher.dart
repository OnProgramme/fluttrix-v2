abstract class Fetcher<T> {
  bool get loading;

  bool get loadingMore;

  bool get error;

  bool get errorMore;

  void setLoading();

  void setError();

  void setLoadingPagination();

  void setErrorPagination();

  void reset();

  void refresh();

  T get value;
  set value(T value);
}