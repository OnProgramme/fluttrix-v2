import 'package:fluttrix/shared/domain/fetcher.dart';
import 'package:get/get.dart';

class AppFetcher<T> extends Fetcher<T> {
  late Rx<T> _data;

  final _loading = false.obs;
  final _error = false.obs;
  final _loadingMore = false.obs;
  final _errorMore = false.obs;

  AppFetcher(T value) {
    _data = Rx<T>(value);
  }

  @override
  T get value => _data.value;

  @override
  bool get error => _error.value;

  @override
  bool get errorMore => _errorMore.value;

  @override
  bool get loading => _loading.value;

  @override
  bool get loadingMore => _loadingMore.value;

  @override
  void reset() {
    _loading.value = false;
    _loadingMore.value = false;
    _error.value = false;
    _errorMore.value = false;
  }

  @override
  void setError() {
    _loading.value = false;
    _loadingMore.value = false;
    _error.value = true;
    _errorMore.value = false;
  }

  @override
  void setErrorPagination() {
    _loading.value = false;
    _loadingMore.value = false;
    _error.value = false;
    _errorMore.value = true;
  }

  @override
  void setLoading() {
    _loading.value = true;
    _loadingMore.value = false;
    _error.value = false;
    _errorMore.value = false;
  }

  @override
  void setLoadingPagination() {
    _loading.value = false;
    _loadingMore.value = true;
    _error.value = false;
    _errorMore.value = false;
  }

  @override
  set value(T value) => _data.value = value;

  @override
  void refresh() {
    _data.refresh();
  }
}