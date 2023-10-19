import 'package:asocapp/app/apirest/network/network.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:get/get.dart';

class AsociationRepository {
  AsociationsApiRest asociationsApiRest = Get.put(AsociationsApiRest());
  StorageService storage = Get.find<StorageService>();

  Future<List<Asociation>?> refreshAsociations() async {
    return asociationsApiRest.refreshAsociations();
  }

  Future<void> storageWrite(String key, dynamic value) async {
    return storage.write(key, value);
  }
}
