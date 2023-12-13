import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/repositorys/repositorys.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleEditController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());

  final formKey = GlobalKey<FormState>();

  final _newArticle = Rx<Article>(Article.clear());
  Article get newArticle => _newArticle.value;
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  final _categoryFocusNode = FocusNode().obs;
  FocusNode get categoryFocusNode => _categoryFocusNode.value;

  final _subcategoryFocusNode = FocusNode().obs;
  FocusNode get subcategoryFocusNode => _subcategoryFocusNode.value;

  List<dynamic> listArticleCategory = ArticleCategory.getListArticleCategory();
  List<dynamic> listArticleSubcategory = ArticleSubcategory.getListArticleSubcategory();

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

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  bool checkIsFormValid() {
    // Helper.eglLogger('i','checkIsFormValid: ${_imageAvatar.value!.path}');
    // Helper.eglLogger('i','checkIsFormValid: ${_imageAvatar.value!.path != ''}');
    return _isFormValid.value = ((formKey.currentState?.validate() ?? false));
  }

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage
    passwordController.text = 'foo@foo.com';
    super.onInit();
  }

  @override
  void onClose() {
    _categoryFocusNode.value.dispose();
    _subcategoryFocusNode.value.dispose();
    super.onClose();
  }
}
