import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/fields_widgets/egl_date_piker.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleDataPage extends StatefulWidget {
  const ArticleDataPage({super.key});

  @override
  State<ArticleDataPage> createState() => _ArticleDataPageState();
}

class _ArticleDataPageState extends State<ArticleDataPage> {
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());

  String language = '';
  String country = '';

  @override
  void initState() {
    super.initState();

    if (articleEditController.newArticle.categoryArticle == '') {
      articleEditController.newArticle.categoryArticle = articleEditController.listArticleCategory[0]['value'];
    }
    articleEditController.actualizelistSubcategory(articleEditController.newArticle.categoryArticle);
    if (articleEditController.newArticle.subcategoryArticle == '') {
      articleEditController.newArticle.subcategoryArticle = articleEditController.listSubcategory[0]['value'];
    }
    if (articleEditController.newArticle.stateArticle == '') {
      articleEditController.newArticle.stateArticle = articleEditController.listArticleState[0]['value'];
    }

    language = articleEditController.session.userConnected.languageUser;
    country = EglHelper.getAppCountryLocale(language);

    articleEditController.firstManageDates();
  }

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
              articleEditController.checkIsFormValid();
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
                    ? articleEditController.listArticleState[0]['value']
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
          // EglInputDateField(
          //   dateController: articleEditController.selectedDatePublication,
          //   textDate: articleEditController.textDatePublication,
          //   firstDate: articleEditController.firstDatePublication,
          //   lastDate: articleEditController.lastDatePublication,
          //   languageCode: language,
          //   countryCode: country,
          //   canReset: false,
          //   labelText: 'lPublicationDate'.tr,
          //   iconLabel: Icons.date_range_rounded,
          //   paddingTop: 0,
          //   paddingLeft: 30,
          //   paddingRight: 30,
          //   paddingBottom: 0,
          //   contentPaddingLeft: 20,
          //   borderColor: Theme.of(context).primaryColor,
          //   borderFocusColor: Theme.of(context).primaryColor,
          //   borderRadius: 10,
          //   onChanged: (newDate) => articleEditController.managePublicationDate(newDate),
          //   onValidator: (_) {
          //     return null;
          //   },
          // ),
          EglDatePiker(
            selectedDate: articleEditController.selectedDatePublication.value,
            firstDate: articleEditController.firstDatePublication.value,
            lastDate: articleEditController.lastDatePublication.value,
            languageCode: language,
            countryCode: country,
            canReset: false,
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
            onDateChanged: (newDate) => articleEditController.managePublicationDate(newDate),
          ),
          //   1.ph,
          // EglInputDateField(
          //   dateController: articleEditController.selectedDateEffective,
          //   textDate: articleEditController.textDateEffective,
          //   firstDate: articleEditController.firstDateEffective,
          //   lastDate: articleEditController.lastDateEffective,
          //   languageCode: language,
          //   countryCode: country,
          //   canReset: false,
          //   labelText: 'lEffectiveDate'.tr,
          //   iconLabel: Icons.date_range_rounded,
          //   paddingTop: 0,
          //   paddingLeft: 30,
          //   paddingRight: 30,
          //   paddingBottom: 0,
          //   contentPaddingLeft: 20,
          //   borderColor: Theme.of(context).primaryColor,
          //   borderFocusColor: Theme.of(context).primaryColor,
          //   borderRadius: 10,
          //   onChanged: (newDate) => articleEditController.manageEffectiveDate(newDate),
          //   onValidator: (_) {
          //     return null;
          //   },
          // ),
          EglDatePiker(
            selectedDate: articleEditController.selectedDateEffective.value,
            firstDate: articleEditController.firstDateEffective.value,
            lastDate: articleEditController.lastDateEffective.value,
            languageCode: language,
            countryCode: country,
            canReset: false,
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
            onDateChanged: (newDate) => articleEditController.manageEffectiveDate(newDate),
          ),
          1.ph,
          // EglInputDateField(
          //   dateController: articleEditController.selectedDateExpiration,
          //   textDate: articleEditController.textDateExpiration,
          //   firstDate: articleEditController.firstDateExpiration,
          //   lastDate: articleEditController.lastDateExpiration,
          //   languageCode: language,
          //   countryCode: country,
          //   labelText: 'Fecha de expiración',
          //   iconLabel: Icons.date_range_rounded,
          //   paddingTop: 0,
          //   paddingLeft: 30,
          //   paddingRight: 30,
          //   paddingBottom: 0,
          //   contentPaddingLeft: 20,
          //   borderColor: Theme.of(context).primaryColor,
          //   borderFocusColor: Theme.of(context).primaryColor,
          //   borderRadius: 10,
          //   onChanged: (newDate) {
          //     articleEditController.newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
          //   },
          //   onValidator: (_) {
          //     return null;
          //   },
          // ),
          EglDatePiker(
            selectedDate: articleEditController.selectedDateExpiration.value,
            firstDate: articleEditController.firstDateExpiration.value,
            lastDate: articleEditController.lastDateExpiration.value,
            languageCode: language,
            countryCode: country,
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
            onDateChanged: (newDate) {
              articleEditController.selectedDateExpiration.value = newDate;
              articleEditController.newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
            },
          ),
        ],
      ),
    );

    // end _formUI
  }

  // firstManageDates() {
  //   articleEditController.newArticle.publicationDateArticle = articleEditController.newArticle.publicationDateArticle == ''
  //       ? EglHelper.datetimeToAaaammdd(DateTime.now())
  //       : articleEditController.newArticle.publicationDateArticle;

  //   articleEditController.newArticle.effectiveDateArticle = articleEditController.newArticle.effectiveDateArticle == ''
  //       ? articleEditController.newArticle.publicationDateArticle
  //       : articleEditController.newArticle.effectiveDateArticle.compareTo(articleEditController.newArticle.publicationDateArticle) < 0
  //           ? articleEditController.newArticle.publicationDateArticle
  //           : articleEditController.newArticle.effectiveDateArticle;

  //   articleEditController.newArticle.expirationDateArticle = articleEditController.newArticle.expirationDateArticle == ''
  //       ? EglHelper.datetimeToAaaammdd(DateTime(4000))
  //       : articleEditController.newArticle.expirationDateArticle.compareTo(articleEditController.newArticle.effectiveDateArticle) < 0
  //           ? articleEditController.newArticle.effectiveDateArticle
  //           : articleEditController.newArticle.expirationDateArticle;

  //   articleEditController.selectedDatePublication.value = EglHelper.aaaammddToDatetime(articleEditController.newArticle.publicationDateArticle);
  //   articleEditController.firstDatePublication.value = articleEditController.selectedDatePublication.value;
  //   articleEditController.textDatePublication.value = articleEditController.selectedDatePublication.value.isAtSameMomentAs(DateTime(4000))
  //       ? 'dd/mm/aaaa'
  //       : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDatePublication.value);

  //   articleEditController.selectedDateEffective.value = EglHelper.aaaammddToDatetime(articleEditController.newArticle.effectiveDateArticle);
  //   articleEditController.firstDateEffective.value = articleEditController.selectedDatePublication.value;
  //   articleEditController.textDateEffective.value = articleEditController.selectedDateEffective.value.isAtSameMomentAs(DateTime(4000))
  //       ? 'dd/mm/aaaa'
  //       : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateEffective.value);

  //   articleEditController.selectedDateExpiration.value = EglHelper.aaaammddToDatetime(articleEditController.newArticle.expirationDateArticle);
  //   articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //   articleEditController.textDateExpiration.value = articleEditController.selectedDateExpiration.value.isAtSameMomentAs(DateTime(4000))
  //       ? 'dd/mm/aaaa'
  //       : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateExpiration.value);
  // }

  // managePublicationDate(DateTime newDate) {
  //   articleEditController.newArticle.publicationDateArticle = EglHelper.datetimeToAaaammdd(newDate);
  //   articleEditController.textDatePublication.value = articleEditController.selectedDatePublication.value.isAtSameMomentAs(DateTime(4000))
  //       ? 'dd/mm/aaaa'
  //       : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDatePublication.value);

  //   if (articleEditController.selectedDatePublication.value.isAfter(articleEditController.selectedDateEffective.value)) {
  //     articleEditController.selectedDateEffective.value = articleEditController.selectedDatePublication.value;
  //     articleEditController.firstDateEffective.value = articleEditController.selectedDatePublication.value;

  //     articleEditController.newArticle.effectiveDateArticle = EglHelper.datetimeToAaaammdd(articleEditController.selectedDateEffective.value);
  //     articleEditController.textDateEffective.value = articleEditController.selectedDateEffective.value.isAtSameMomentAs(DateTime(4000))
  //         ? 'dd/mm/aaaa'
  //         : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateEffective.value);

  //     if (articleEditController.selectedDateEffective.value.isAfter(articleEditController.selectedDateExpiration.value)) {
  //       articleEditController.selectedDateExpiration.value = articleEditController.selectedDateEffective.value;
  //       articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //       articleEditController.newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(articleEditController.selectedDateExpiration.value);
  //       articleEditController.textDateExpiration.value = articleEditController.selectedDateExpiration.value.isAtSameMomentAs(DateTime(4000))
  //           ? 'dd/mm/aaaa'
  //           : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateExpiration.value);
  //     } else {
  //       articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //     }
  //   } else {
  //     articleEditController.firstDateEffective.value = articleEditController.selectedDatePublication.value;
  //     articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //   }
  // }

  // manageEffectiveDate(DateTime newDate) {
  //   articleEditController.newArticle.effectiveDateArticle = EglHelper.datetimeToAaaammdd(newDate);
  //   articleEditController.textDateEffective.value = articleEditController.selectedDateEffective.value.isAtSameMomentAs(DateTime(4000))
  //       ? 'dd/mm/aaaa'
  //       : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateEffective.value);

  //   if (articleEditController.selectedDateEffective.value.isAfter(articleEditController.selectedDateExpiration.value)) {
  //     articleEditController.selectedDateExpiration.value = articleEditController.selectedDateEffective.value;
  //     articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //     articleEditController.newArticle.expirationDateArticle = EglHelper.datetimeToAaaammdd(articleEditController.selectedDateExpiration.value);
  //     articleEditController.textDateExpiration.value = articleEditController.selectedDateExpiration.value.isAtSameMomentAs(DateTime(4000))
  //         ? 'dd/mm/aaaa'
  //         : DateFormat('dd/MM/yyyy').format(articleEditController.selectedDateExpiration.value);
  //   } else {
  //     articleEditController.firstDateExpiration.value = articleEditController.selectedDateEffective.value;
  //   }
  // }

// End class
}
