import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  GetStorage? _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }

  T read<T>(String key, {dynamic nullT}) {
    var read = _box!.read(key) ?? nullT;
    return read;
  }

  Map<String, dynamic> readObject(String key) {
    final read = _box!.read(key);
    Map<String, dynamic> objectJson = read == null ? {} : json.decode(read);
    return objectJson;
  }

  Future<void> write(String key, dynamic value) async {
    await _box!.write(key, value);
  }

  Future<void> writeObject(String key, dynamic value) async {
    String data = json.encode(value.toJson());
    await _box!.write(key, data);
  }

  Future<void> remove(String key) async {
    await _box!.remove(key);
  }
}
