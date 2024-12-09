import 'package:flutter/cupertino.dart';

abstract class LocalStorage {
  Future<void> write(String key, dynamic value);
  Future<dynamic> read(String key);
  Future<void> delete(String key);
  Future<void> deleteMany(List<String> keys);
  Future<void> clear();
  void listenKey(String key, ValueSetter<dynamic> onChanged);
}
