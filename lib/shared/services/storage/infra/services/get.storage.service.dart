import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttrix/shared/services/storage/domain/core/local.storage.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageService implements LocalStorage {
  final _storage = GetStorage();

  @override
  Future<void> clear() async {
    await _storage.erase();
  }

  @override
  Future<void> delete(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<void> deleteMany(List<String> keys) async {
    for (String key in keys) {
      await _storage.remove(key);
    }
  }

  @override
  Future read(String key) async {
    final response = await _storage.read(key);
    return response != null ? json.decode(response) : null;
  }

  @override
  Future<void> write(String key, value) async {
    await _storage.write(key, json.encode(value));
  }

  @override
  void listenKey(String key, ValueSetter onChanged) {
    _storage.listenKey(key, (value) {
      onChanged(value);
    });
  }
}
