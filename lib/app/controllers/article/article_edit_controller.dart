import 'dart:async';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/api_models/article_plain_api_model.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/repositorys/repositorys.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ArticleEditController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());

  bool isNew = true;

  final _oldArticle = Rx<Article>(Article.clear());
  Article get oldArticle => _oldArticle.value;
  set oldArticle(Article value) => _oldArticle.value = value;

  final _newArticle = Rx<Article>(Article.clear());
  Article get newArticle => _newArticle.value;
  set newArticle(Article value) => _newArticle.value = value;

  final _articleItemsCount = 0.obs;
  int get articleItemsCount => _newArticle.value.itemsArticle.length;

  // final _newArticleItems = Rx<List<ItemArticle>>([]);
  // List<ItemArticle> get newArticleItems => _newArticleItems.value;
  // set newArticleItems(List<ItemArticle> value) {
  //   _newArticleItems.value = value;
  //   _articleItemsCount.value = _newArticleItems.value.length;
  // }

  set addItemArticle(ItemArticle value) {
    // _newArticleItems.value.add(value);
    _newArticle.value.itemsArticle.add(value);
    // _newArticle.value.itemsArticle = _newArticleItems.value;
    _articleItemsCount.value = _newArticle.value.itemsArticle.length;
    _newArticle.refresh();
  }

  void insertItemArticle(int index, ItemArticle item) {
    // _newArticleItems.value.insert(index, item);
    _newArticle.value.itemsArticle.insert(index, item);
    _articleItemsCount.value = _newArticle.value.itemsArticle.length;
    // _newArticle.value.itemsArticle = _newArticleItems.value;
    _newArticle.refresh();
  }

  ItemArticle deleteItemArticle(int value) {
    // final ItemArticle item = _newArticleItems.value.removeAt(value);
    final ItemArticle item = _newArticle.value.itemsArticle.removeAt(value);
    _articleItemsCount.value = _newArticle.value.itemsArticle.length;
    // _newArticle.value.itemsArticle = _newArticleItems.value;
    _newArticle.refresh();
    return item;
  }

  discardItemArticle(ItemArticle value) {
    // _newArticleItems.value.removeWhere((item) => item.idItemArticle == value.idItemArticle);
    _newArticle.value.itemsArticle.removeWhere((item) => item.idItemArticle == value.idItemArticle);
    _newArticle.refresh();
  }

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  Rx<DateTime> selectedDatePublication = DateTime.now().obs;
  Rx<DateTime> firstDatePublication = DateTime.now().obs;
  Rx<DateTime> lastDatePublication = DateTime(3000).obs;
  Rx<String> textDatePublication = 'dd/mm/aaaa'.obs;
  Rx<DateTime> selectedDateEffective = DateTime.now().obs;
  Rx<DateTime> firstDateEffective = DateTime.now().obs;
  Rx<DateTime> lastDateEffective = DateTime(3000).obs;
  Rx<String> textDateEffective = 'dd/mm/aaaa'.obs;
  Rx<DateTime> selectedDateExpiration = DateTime(4000).obs;
  Rx<DateTime> firstDateExpiration = DateTime.now().obs;
  Rx<DateTime> lastDateExpiration = DateTime(4001).obs;
  Rx<String> textDateExpiration = 'dd/mm/aaaa'.obs;

  final _titleArticleFocusNode = FocusNode().obs;
  FocusNode get titleArticleFocusNode => _titleArticleFocusNode.value;

  final _abstractArticleFocusNode = FocusNode().obs;
  FocusNode get abstractArticleFocusNode => _abstractArticleFocusNode.value;

  final _categoryFocusNode = FocusNode().obs;
  FocusNode get categoryFocusNode => _categoryFocusNode.value;

  final _subcategoryFocusNode = FocusNode().obs;
  FocusNode get subcategoryFocusNode => _subcategoryFocusNode.value;

  final _stateFocusNode = FocusNode().obs;
  FocusNode get stateFocusNode => _stateFocusNode.value;

  List<dynamic> listArticleCategory = ArticleCategory.getListArticleCategory();
  List<dynamic> listArticleSubcategory = ArticleSubcategory.getListArticleSubcategory();
  List<dynamic> listArticleState = ArticleState.getListArticleState();

  final _listSubcategory = Rx<List<dynamic>>([]);
  List<dynamic> get listSubcategory => _listSubcategory.value;
  void actualizelistSubcategory(String value) {
    _listSubcategory.value = [];

    final List<dynamic> list = listArticleSubcategory
        .where((element) => element['category'].toString() == value)
        .map((e) => {'value': e['value'], 'name': e['name']})
        .toList();

    _listSubcategory.value = list;
  }

  final _imageCoverChanged = false.obs;
  bool get imageCoverChanged => _imageCoverChanged.value;
  set imageCoverChanged(bool value) => _imageCoverChanged.value = value;

  final _imageCover = Rx<XFile?>(XFile(''));
  XFile? get imageCover => _imageCover.value;
  set imageCover(XFile? value) => _imageCover.value = value;

  final _appLogo = ''.obs;
  String get appLogo => _appLogo.value;

  final _iconUserDefaultProfile = ''.obs;
  String get iconUserDefaultProfile => _iconUserDefaultProfile.value;
  set iconUserDefaultProfile(String value) => _iconUserDefaultProfile.value = value;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;
  set isFormValid(bool value) => _isFormValid.value = value;

  final _canSave = false.obs;
  bool get canSave => _canSave.value;

  bool titleOk = false;
  int minLengthTitle = 4;
  int maxLengthTitle = 100;
  bool abstractOk = false;
  int minLengthAbstract = 4;
  int maxLengthAbstract = 200;

  bool checkIsFormValid() {
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path}');
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path != ''}');
    bool valid = checkFields();
    _isFormValid.value = valid;
    return _isFormValid.value;
  }

  bool checkFields() {
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path}');
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path != ''}');
    bool valid = (titleOk && abstractOk && (_imageCoverChanged.value || !_newArticle.value.coverImageArticle.isDefault));

    if (valid && _newArticle.value.itemsArticle.isNotEmpty) {
      valid = _newArticle.value.itemsArticle.every((ItemArticle item) {
        bool value = (item.textItemArticle != '' || !item.imageItemArticle.isDefault);
        return value;
      });
      // Llamar al método 'myMethod' dinámicamente
    }

    _canSave.value = valid;
    return _canSave.value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // Simulating obtaining the user name from some local storage

    _appLogo.value = await EglImagesPath.getAppIconUserDefault();
    _iconUserDefaultProfile.value = _appLogo.value;
    _articleItemsCount.value = _newArticle.value.itemsArticle.length;
    // // Escucha cambios en selectedDatePublication
    // ever(selectedDatePublication, (DateTime date) {
    // });
  }

  @override
  void onClose() {
    _titleArticleFocusNode.value.dispose();
    _abstractArticleFocusNode.value.dispose();
    _categoryFocusNode.value.dispose();
    _subcategoryFocusNode.value.dispose();
    _stateFocusNode.value.dispose();
    super.onClose();
  }

  Future<HttpResult<ArticleUserResponse>?> createArticle(
      BuildContext context, ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    loading = true;

    try {
      loading = false;
      return articlesRepository.createArticle(articlePlain, imageCoverArticle, articleItems);
    } catch (e) {
      EglHelper.toastMessage((e.toString()));
      loading = false;
      return null;
    }
  }

  Future<HttpResult<ArticleUserResponse>?> modifyArticle(
      BuildContext context, ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    loading = true;

    try {
      loading = false;
      return articlesRepository.modifyArticle(articlePlain, imageCoverArticle, articleItems);
    } catch (e) {
      EglHelper.toastMessage((e.toString()));
      loading = false;
      return null;
    }
  }

  firstManageDates() {
    newArticle.publicationDateArticle =
        newArticle.publicationDateArticle == '' ? EglHelper.datetimeToAaaammdd(DateTime.now()) : newArticle.publicationDateArticle;

    newArticle.effectiveDateArticle = newArticle.effectiveDateArticle == ''
        ? newArticle.publicationDateArticle
        : newArticle.effectiveDateArticle.compareTo(newArticle.publicationDateArticle) < 0
            ? newArticle.publicationDateArticle
            : newArticle.effectiveDateArticle;

    newArticle.expirationDateArticle = newArticle.expirationDateArticle == ''
        ? EglHelper.datetimeToAaaammdd(DateTime(4000))
        : newArticle.expirationDateArticle.compareTo(newArticle.effectiveDateArticle) < 0
            ? newArticle.effectiveDateArticle
            : newArticle.expirationDateArticle;

    selectedDatePublication.value = EglHelper.aaaammddToDatetime(newArticle.publicationDateArticle);
    firstDatePublication.value = selectedDatePublication.value;
    textDatePublication.value = selectedDatePublication.value.isAtSameMomentAs(DateTime(4000))
        ? 'dd/mm/aaaa'
        : DateFormat('dd/MM/yyyy').format(selectedDatePublication.value);

    selectedDateEffective.value = EglHelper.aaaammddToDatetime(newArticle.effectiveDateArticle);
    firstDateEffective.value = selectedDatePublication.value;
    textDateEffective.value =
        selectedDateEffective.value.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(selectedDateEffective.value);

    selectedDateExpiration.value = EglHelper.aaaammddToDatetime(newArticle.expirationDateArticle);
    firstDateExpiration.value = selectedDateEffective.value;
    textDateExpiration.value =
        selectedDateExpiration.value.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(selectedDateExpiration.value);
  }

  managePublicationDate(DateTime newDate) {
    selectedDatePublication.value = newDate;
    newArticle.publicationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
    textDatePublication.value = newDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(newDate);

    if (newDate.isAfter(selectedDateEffective.value)) {
      selectedDateEffective.value = newDate;
      firstDateEffective.value = newDate;

      newArticle.effectiveDateArticle = EglHelper.datetimeToAaaammdd(newDate);
      textDateEffective.value = newDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(newDate);

      if (newDate.isAfter(selectedDateExpiration.value)) {
        selectedDateExpiration.value = newDate;
        firstDateExpiration.value = newDate;
        newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
        textDateExpiration.value = newDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(newDate);
      } else {
        firstDateExpiration.value = newDate;
      }
    } else {
      firstDateEffective.value = newDate;
      firstDateExpiration.value = selectedDateEffective.value;
    }
  }

  manageEffectiveDate(DateTime newDate) {
    selectedDateEffective.value = newDate;
    newArticle.effectiveDateArticle = EglHelper.datetimeToAaaammdd(newDate);
    textDateEffective.value = newDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(newDate);

    if (newDate.isAfter(selectedDateExpiration.value)) {
      selectedDateExpiration.value = newDate;
      firstDateExpiration.value = newDate;
      newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
      textDateExpiration.value = newDate.isAtSameMomentAs(DateTime(4000)) ? 'dd/mm/aaaa' : DateFormat('dd/MM/yyyy').format(newDate);
    } else {
      firstDateExpiration.value = newDate;
    }
  }

  // fin class
}
