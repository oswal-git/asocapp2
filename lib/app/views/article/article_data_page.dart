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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          20.ph,
          _formUI(context, articleEditController),
        ],
      ),
    );
  }

  Widget _formUI(BuildContext context, ArticleEditController articleEditController) {
    if (articleEditController.newArticle.categoryArticle == '') {
      articleEditController.newArticle.categoryArticle = articleEditController.listArticleCategory[0]['value'];
    }
    articleEditController.actualizelistSubcategory(articleEditController.newArticle.categoryArticle);

    articleEditController.selectedDatePublication.value = articleEditController.newArticle.publicationDateArticle == ''
        ? DateTime.now()
        : EglHelper.aaaammddToDatetime(articleEditController.newArticle.publicationDateArticle);
    articleEditController.selectedDateEffective.value = articleEditController.newArticle.effectiveDateArticle == ''
        ? DateTime.now().add(const Duration(days: 10))
        : EglHelper.aaaammddToDatetime(articleEditController.newArticle.effectiveDateArticle);
    articleEditController.firstDateEffective.value = articleEditController.selectedDatePublication.value;
    articleEditController.selectedDateExpiration.value = articleEditController.newArticle.expirationDateArticle == ''
        ? DateTime(4000)
        : EglHelper.aaaammddToDatetime(articleEditController.newArticle.expirationDateArticle);
    articleEditController.firstDateExpiration.value = articleEditController.selectedDateExpiration.value;

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
              iconLabel: Icons.subject),
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
            iconLabel: Icons.security_update_warning_sharp,
          ),
          20.ph,
          EglInputDateField(
            dateController: articleEditController.selectedDatePublication,
            firstDate: articleEditController.firstDatePublication,
            lastDate: articleEditController.lastDatePublication,
            // labelText: 'Fecha de Nacimiento',
            //   ),
            //   EglInputDateField(
            labelText: 'lPublicationDate'.tr,
            iconLabel: Icons.date_range_rounded,
            paddingTop: 0,
            paddingLeft: 30,
            paddingRight: 30,
            paddingBottom: 0,
            contentPaddingLeft: 20,
            borderColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            onChanged: (newDate) {
              articleEditController.newArticle.publicationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
              if (articleEditController.newArticle.publicationDateArticle.compareTo(articleEditController.newArticle.effectiveDateArticle) > 0) {
                if (articleEditController.newArticle.publicationDateArticle.compareTo(articleEditController.newArticle.expirationDateArticle) > 0) {
                  articleEditController.selectedDateExpiration.value = newDate;
                }
                articleEditController.selectedDateEffective.value = newDate;
                articleEditController.firstDateEffective.value = newDate;
                articleEditController.firstDateExpiration.value = newDate;
              } else if (articleEditController.newArticle.publicationDateArticle.compareTo(articleEditController.newArticle.effectiveDateArticle) <
                  0) {
                articleEditController.firstDateEffective.value = newDate;
                articleEditController.firstDateExpiration.value = newDate;
                // articleEditController.firstDateEffective.refresh();
              } else {}
            },
            onValidator: (_) {
              return null;
            },
          ),
          //   1.ph,
          EglInputDateField(
            dateController: articleEditController.selectedDateEffective,
            firstDate: articleEditController.firstDateEffective,
            lastDate: articleEditController.lastDateEffective,
            // labelText: 'Fecha de Nacimiento',
            //   ),
            //   EglInputDateField(
            labelText: 'lEffectiveDate'.tr,
            iconLabel: Icons.date_range_rounded,
            paddingTop: 0,
            paddingLeft: 30,
            paddingRight: 30,
            paddingBottom: 0,
            contentPaddingLeft: 20,
            borderColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            onChanged: (newDate) {
              articleEditController.newArticle.effectiveDateArticle = EglHelper.datetimeToAaaammdd(newDate);
              if (articleEditController.newArticle.effectiveDateArticle.compareTo(articleEditController.newArticle.expirationDateArticle) > 0) {
                articleEditController.selectedDateExpiration.value = newDate;
                articleEditController.firstDateExpiration.value = newDate;
              } else if (articleEditController.newArticle.effectiveDateArticle.compareTo(articleEditController.newArticle.expirationDateArticle) <
                  0) {
                articleEditController.firstDateExpiration.value = newDate;
                // articleEditController.firstDateEffective.refresh();
              } else {}
            },
            onValidator: (_) {
              return null;
            },
          ),
          //   1.ph,
          EglInputDateField(
            dateController: articleEditController.selectedDateExpiration,
            firstDate: articleEditController.firstDateExpiration,
            lastDate: articleEditController.lastDateExpiration,
            // labelText: 'Fecha de Nacimiento',
            //   ),
            //   EglInputDateField(
            labelText: 'Fecha de expiración',
            iconLabel: Icons.date_range_rounded,
            paddingTop: 0,
            paddingLeft: 30,
            paddingRight: 30,
            paddingBottom: 0,
            contentPaddingLeft: 20,
            borderColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            onChanged: (newDate) {
              articleEditController.newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
            },
            onValidator: (_) {
              return null;
            },
          ),
        ],
      ),
    );
  }
}
