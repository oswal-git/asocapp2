import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleDataPage extends StatelessWidget {
  ArticleDataPage({super.key});

  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('ArticleEditionPage'));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        20.ph,
        Form(
          key: articleEditController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Habilita la validación cuando el usuario interactúa con el formulario
          onChanged: () {},
          child: _formUI(context, articleEditController),
        ),
      ],
    );
  }

  Widget _formUI(BuildContext context, ArticleEditController articleEditController) {
    if (articleEditController.newArticle.categoryArticle == '') {
      articleEditController.newArticle.categoryArticle = articleEditController.listArticleCategory[0]['value'];
    }
    articleEditController.actualizelistSubcategory(articleEditController.newArticle.categoryArticle);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.ph,
          EglDropdownList(
            context: context,
            labelText: 'lArticleCategory'.tr,
            hintText: 'hArticleCategory'.tr,
            contentPaddingLeft: 20,
            focusNode: articleEditController.categoryFocusNode,
            nextFocusNode: articleEditController.subcategoryFocusNode,
            lstData: articleEditController.listArticleCategory,
            value: articleEditController.newArticle.categoryArticle,
            onChanged: (onChangedVal) {
              articleEditController.newArticle.categoryArticle = onChangedVal;

              articleEditController.actualizelistSubcategory(onChangedVal);
              articleEditController.newArticle.subcategoryArticle =
                  articleEditController.listSubcategory.isNotEmpty ? articleEditController.listSubcategory[0]['value'] : '';
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'iselectCategory'.tr;
              }
              return null;
            },
            borderFocusColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0,
            paddingBottom: 0,
            borderRadius: 10,
            optionValue: "value",
            optionLabel: "name",
            iconLabel: Icons.category,
          ),
          20.ph,
          EglDropdownList(
            context: context,
            labelText: 'lArticleSubcategory'.tr,
            hintText: 'hArticleSubcategory'.tr,
            contentPaddingLeft: 20,
            focusNode: articleEditController.subcategoryFocusNode,
            nextFocusNode: articleEditController.stateFocusNode,
            lstData: articleEditController.listSubcategory,
            value: articleEditController.newArticle.subcategoryArticle != ''
                ? articleEditController.newArticle.subcategoryArticle
                : articleEditController.listSubcategory.isNotEmpty
                    ? articleEditController.listSubcategory[0]['value']
                    : '',
            onChanged: (onChangedVal) {
              articleEditController.newArticle.subcategoryArticle = onChangedVal;
              articleEditController.checkIsFormValid();
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'iselectSubcategory'.tr;
              }
              return null;
            },
            borderFocusColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0,
            paddingBottom: 0,
            borderRadius: 10,
            optionValue: "value",
            optionLabel: "name",
            iconLabel: Icons.category,
          ),
          20.ph,
          EglDropdownList(
            context: context,
            labelText: 'lArticleState'.tr,
            hintText: 'hArticleState'.tr,
            contentPaddingLeft: 20,
            focusNode: articleEditController.stateFocusNode,
            nextFocusNode: articleEditController.stateFocusNode,
            lstData: articleEditController.listArticleState,
            value: articleEditController.newArticle.stateArticle != ''
                ? articleEditController.newArticle.stateArticle
                : articleEditController.listArticleState.isNotEmpty
                    ? articleEditController.listSubcategory[0]['value']
                    : '',
            onChanged: (onChangedVal) {
              articleEditController.newArticle.stateArticle = onChangedVal;
              articleEditController.checkIsFormValid();
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'iSelectState'.tr;
              }
              return null;
            },
            borderFocusColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0,
            paddingBottom: 0,
            borderRadius: 10,
            optionValue: "value",
            optionLabel: "name",
            iconLabel: Icons.category,
          ),
        ],
      ),
    );
  }
}
