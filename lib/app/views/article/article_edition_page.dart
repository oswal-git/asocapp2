import 'dart:ui';

import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/edit_item_article.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleEditionPage extends StatefulWidget {
  const ArticleEditionPage({super.key});

  @override
  State<ArticleEditionPage> createState() => _ArticleEditionPageState();
}

class _ArticleEditionPageState extends State<ArticleEditionPage> {
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());
  final SessionService session = Get.put<SessionService>(SessionService());

  Color toolbarColor = Colors.grey.shade200;
  bool titleFocus = false;
  String plainTitle = '';
  String titleBefore = '';
  String textValidateTitle = '';
  String titleIni = '';
  bool abstractFocus = false;
  String plainAbstract = '';
  String abstractBefore = '';
  String textValidateAbstract = '';
  String abstractIni = '';

  @override
  void initState() {
    super.initState();
    titleIni = articleEditController.newArticle.titleArticle;
    titleBefore = articleEditController.newArticle.titleArticle;
    abstractIni = articleEditController.newArticle.abstractArticle;
    abstractBefore = articleEditController.newArticle.abstractArticle;

    articleEditController.titleArticleFocusNode.addListener(
      () {
        if (articleEditController.titleArticleFocusNode.hasFocus) {
          EglHelper.eglLogger('i', "tiene el foco");
        } else {
          EglHelper.eglLogger('i', "perdió el foco");
          articleEditController.checkIsFormValid();
        }
      },
    );

    articleEditController.abstractArticleFocusNode.addListener(
      () {
        if (articleEditController.abstractArticleFocusNode.hasFocus) {
          EglHelper.eglLogger('i', "tiene el foco");
        } else {
          EglHelper.eglLogger('i', "perdió el foco");
          articleEditController.checkIsFormValid();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.00),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
          border: Border.all(
            color: Colors.yellow, // color del borde
            width: 2.0, // ancho del borde
          ),
        ),
        child: Obx(
          () => Column(
            children: [
              30.ph,
              // Text title
              EglInputMultiLineField(
                focusNode: articleEditController.titleArticleFocusNode,
                nextFocusNode: articleEditController.abstractArticleFocusNode,
                currentValue: articleEditController.newArticle.titleArticle,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                iconLabel: Icons.person_pin,
                // ronudIconBorder: true,
                labelText: 'lTitleArticle'.tr,
                hintText: 'hTitleArticle'.tr,
                maxLines: null,
                maxLength: articleEditController.maxLengthTitle,
                // icon: Icons.person_pin,
                onChanged: (value) {
                  articleEditController.newArticle.titleArticle = value;
                  titleFocus = titleFocus ? titleFocus : articleEditController.titleArticleFocusNode.hasFocus;

                  // articleEditController.checkFields();
                  //   titleKey.currentState?.validate();
                },
                onValidator: (value) {
                  if (titleFocus) {
                    articleEditController.titleOk = false;
                    if (value!.isEmpty) return 'Introduzca el título del artículo';
                    if (value.length < articleEditController.minLengthTitle) return 'El título ha de tener 4 carácteres como mínimo ';
                    if (value.length > articleEditController.maxLengthTitle) return 'El título ha de tener 100 carácteres como máximo ';
                    articleEditController.titleOk = true;
                  }
                  return null;
                },
              ),
              20.ph,
              // Abstract
              EglInputMultiLineField(
                focusNode: articleEditController.abstractArticleFocusNode,
                nextFocusNode: articleEditController.abstractArticleFocusNode,
                currentValue: articleEditController.newArticle.abstractArticle,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                iconLabel: Icons.person_pin,
                // ronudIconBorder: true,
                labelText: 'lAbstractArticle'.tr,
                hintText: 'hAbstractArticle'.tr,
                maxLines: null,
                maxLength: articleEditController.maxLengthAbstract,
                // icon: Icons.person_pin,
                onChanged: (value) {
                  articleEditController.newArticle.abstractArticle = value;
                  abstractFocus = abstractFocus ? abstractFocus : articleEditController.abstractArticleFocusNode.hasFocus;
                  // articleEditController.checkFields();
                  //   abstractKey.currentState?.validate();
                },
                onValidator: (value) {
                  if (abstractFocus) {
                    articleEditController.abstractOk = false;
                    if (value!.isEmpty) return 'Introduzca el abstract del artículo';
                    if (value.length < articleEditController.minLengthAbstract) return 'El abstract ha de tener 4 carácteres como mínimo ';
                    if (value.length > articleEditController.maxLengthAbstract) return 'El abstract ha de tener 200 carácteres como máximo ';
                    articleEditController.abstractOk = true;
                  }
                  return null;
                },
              ),

              20.ph,
              (articleEditController.imageCoverChanged || !articleEditController.newArticle.coverImageArticle.isDefault) ? 30.ph : 20.ph,
              // Cover widget
              Container(
                // width: MediaQuery.of(context).size.width / 2,
                margin: const EdgeInsets.symmetric(horizontal: 30.00),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
                  border: Border.all(
                    color: Colors.transparent, // color del borde
                    width: 2.0, // ancho del borde
                  ),
                ),
                child: EglImageWidget(
                  image: articleEditController.newArticle.coverImageArticle,
                  defaultImage: EglImagesPath.appCoverDefault,
                  isEditable: true,
                  canDefault: false,
                  onChange: (ImageArticle image) {
                    // Lógica para recuperar la imagen por defecto
                    articleEditController.newArticle.coverImageArticle = image.copyWith();
                    articleEditController.checkIsFormValid();
                    EglHelper.eglLogger('i', 'onChange: ${articleEditController.newArticle.coverImageArticle.toString()}');
                  },
                  onPressedDefault: (ImageArticle image) {
                    // Lógica para recuperar la imagen por defecto
                    articleEditController.newArticle.coverImageArticle = image.copyWith();
                    articleEditController.checkIsFormValid();
                    EglHelper.eglLogger('i', 'onPressedDefault: ${articleEditController.newArticle.coverImageArticle.toString()}');
                  },
                  onPressedRestore: (ImageArticle image) {
                    // Lógica para restaurar la imagen inicial
                    articleEditController.newArticle.coverImageArticle = image.copyWith();
                    articleEditController.checkIsFormValid();
                    EglHelper.eglLogger('i', 'onPressedRestore: ${articleEditController.newArticle.coverImageArticle.toString()}');
                  },
                ),
              ),
              40.ph,
              if (articleEditController.newArticleItems.isNotEmpty)
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (ItemArticle item in articleEditController.newArticleItems)
                      Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red[400],
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.white,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            // Borrar mensaje
                            articleEditController.discardItemArticle(item);
                          }
                        },
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            return false;
                          }
                          return true;
                        },
                        child: Container(
                            key: UniqueKey(),
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            padding: const EdgeInsets.only(bottom: 10.0, top: 40.0),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
                              border: Border(
                                top: BorderSide(
                                  color: EglColorsApp.borderTileArticleColor, // color del borde
                                  width: 2.0, // ancho del borde)
                                ),
                              ),
                            ),
                            child: EditItemArticle(itemArticle: item)),
                        // child: Text('itemIndex: $index'),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    // setState(() {
                    final ItemArticle item = articleEditController.deleteItemArticle(oldIndex);
                    articleEditController.insertItemArticle(newIndex, item);
                    // });
                  },
                  proxyDecorator: (Widget child, int index, Animation<double> animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, _) {
                        final animValue = Curves.easeInOut.transform(animation.value);
                        final double elevation = lerpDouble(1, 1.05, animValue)!;
                        return Material(
                          elevation: elevation,
                          color: Colors.grey[200],
                          shadowColor: Colors.red[100],
                          child: Transform.scale(
                            scale: elevation,
                            child: child,
                          ),
                        );
                      },
                    );
                  },
                ),

              20.ph,
              // if (articleEditController.newArticle.itemsArticle.isEmpty)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EglCircleIconButton(
                        // key: UniqueKey(),
                        backgroundColor: const Color(0xFFAAAAAA),
                        icon: Icons.add_circle_outline, // Relojito hacia atrás
                        onPressed: () {
                          ItemArticle item = ItemArticle.clear();
                          item.idArticleItemArticle = articleEditController.newArticle.idArticle;
                          item.idItemArticle = articleEditController.articleItemsCount;
                          item.imageItemArticle.modify(
                            src: EglImagesPath.appCoverDefault,
                            nameFile: EglHelper.getNameFilePath(EglImagesPath.appCoverDefault),
                            isDefault: true,
                          );
                          articleEditController.addItemArticle = item;
                        },
                      ),
                      10.pw,
                    ],
                  ),
                  20.ph,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// functions
  Future<String> validateTitle(String text, {int minLength = 0, int maxLength = 99999}) async {
    String textValidateTitle = '';

    if (text.isEmpty && minLength > 0) {
      textValidateTitle = 'Introduzca el título del artículo';
    } else if (text.length < minLength) {
      textValidateTitle = 'El título ha de tener $minLength carácteres como mínimo ';
    } else if (text.length > maxLength) {
      textValidateTitle = 'El título ha de tener $maxLength carácteres como máximo ';
      // controller.getTe
    } else {
      textValidateTitle = '';
    }
    return textValidateTitle;
  }

  Future<String> validateAbstract(String text, {int minLength = 0, int maxLength = 99999}) async {
    String textValidateAbstract = '';

    if (text.isEmpty && minLength > 0) {
      textValidateAbstract = 'Introduzca el abstract del artículo';
    } else if (text.length < minLength) {
      textValidateAbstract = 'El abstract ha de tener $minLength carácteres como mínimo ';
    } else if (text.length > maxLength) {
      textValidateAbstract = 'El abstract ha de tener $maxLength carácteres como máximo ';
      // controller.getTe
    } else {
      textValidateAbstract = '';
    }
    return textValidateAbstract;
  }

// end
}
