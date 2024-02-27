import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/asociations_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';

class AsociationController extends GetxController {
  final AsociationRepository asociationRepository = Get.put(AsociationRepository());
  final Logger logger = Logger();

  final _asociations = <Asociation>[].obs;
  List<Asociation> get asociations => _asociations;
  set asociations(value) => _asociations.value = value;

  final _selectedAsociation = Rx<Asociation>(Asociation.clear());
  Asociation get selectedAsociation => _selectedAsociation.value;

  final _asociationsList = <dynamic>[].obs;
  List<dynamic> get asociationsList => _asociationsList;

  @override
  onInit() async {
    super.onInit();
    await refreshAsociationsList();
  }

  Future<List<dynamic>> refreshAsociationsList() async {
    if (_asociations.isEmpty) {
      await refreshAsociations();
    }
    // print('Response body: ${result}');
    if (_asociations.isNotEmpty) {
      _asociationsList.value = _asociations
          .toJson()
          .map((item) => {
                'id': item.idAsociation,
                'name': item.shortNameAsociation,
              })
          .toList();
    }
    EglHelper.eglLogger('i', _asociationsList.toString());
    return Future.value(asociationsList);
  }

  Future<void> refreshAsociations() async {
    List<Asociation>? result;

    if (_asociations.isEmpty) {
      result = await asociationRepository.refreshAsociations();
      _asociations.value = [];
      if (result != null) {
        result.map((asociation) => _asociations.add(asociation)).toList();
      }
    }
  }

  Future<void> clearAsociations() async {
    _asociations.value = [];
  }

  void addAsociation(Asociation asociation) {
    _asociations.add(asociation);
  }

  void setSelectedAsociation(int idAsociation) async {
    _selectedAsociation.value = _asociations.firstWhere((element) => idAsociation == element.idAsociation);

    logger.d('AsociationsService: ${_selectedAsociation.value.longNameAsociation}');

    await asociationRepository.storageWrite(selectIdAsociationKey, idAsociation.toString());
  }

  Asociation getAsociationById(int idAsociation) {
    Asociation searchedAsociation = _asociations.firstWhere((element) => idAsociation == element.idAsociation);

    EglHelper.eglLogger('d', 'getAsociationById: ${searchedAsociation.longNameAsociation}');

    return searchedAsociation;
  }
}
