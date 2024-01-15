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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('ArticleEditionPage'));
    bool titleFocus = false;
    bool abstractFocus = false;

    return Obx(
      () => ListView(
        children: [
          20.ph,
          // Title
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
            maxLength: 100,
            // icon: Icons.person_pin,
            onChanged: (value) {
              articleEditController.newArticle.titleArticle = value;
              titleFocus = articleEditController.titleArticleFocusNode.hasFocus;
              //   titleKey.currentState?.validate();
            },
            onValidator: (value) {
              if (titleFocus) {
                if (value!.isEmpty) return 'Introduzca el título del artículo';
                if (value.length < 4) return 'El título ha de tener 4 carácteres como mínimo ';
                if (value.length > 100) return 'El título ha de tener 100 carácteres como máximo ';
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
            maxLength: 200,
            // icon: Icons.person_pin,
            onChanged: (value) {
              articleEditController.newArticle.abstractArticle = value;
              abstractFocus = articleEditController.abstractArticleFocusNode.hasFocus;
              //   abstractKey.currentState?.validate();
            },
            onValidator: (value) {
              if (abstractFocus) {
                if (value!.isEmpty) return 'Introduzca el abstract del artículo';
                if (value.length < 4) return 'El abstract ha de tener 4 carácteres como mínimo ';
                if (value.length > 200) return 'El abstract ha de tener 200 carácteres como máximo ';
              }
              return null;
            },
          ),
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
              onPressedDefault: (ImageArticle image) {
                // Lógica para recuperar la imagen por defecto
                articleEditController.newArticle.coverImageArticle = image.copyWith();
                EglHelper.eglLogger('i', 'onPressedDefault: ${articleEditController.newArticle.coverImageArticle.toString()}');
              },
              onPressedRestore: (ImageArticle image) {
                // Lógica para restaurar la imagen inicial
                articleEditController.newArticle.coverImageArticle = image.copyWith();
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

                  // ItemArticle item = articleEditController.newArticleItems[index];
                  // if (item.imageItemArticle.isDefault) {
                  //   item.imageItemArticle.modify(
                  //     src: EglImagesPath.appCoverDefault,
                  //     nameFile: EglHelper.getNameFilePath(EglImagesPath.appCoverDefault),
                  //     isDefault: true,
                  //   );
                  // }
                  Container(
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
                    child: EditItemArticle(itemArticle: item),
                    // child: Text('itemIndex: $index'),
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                setState(() {
                  final ItemArticle item = articleEditController.deleteItemArticle(oldIndex);
                  articleEditController.insertItemArticle(newIndex, item);
                });
              },
              // proxyDecorator: (Widget child, int index, Animation<double> animation) {
              //   return AnimatedBuilder(
              //     animation: animation,
              //     builder: (BuildContext context, _) {
              //       final animValue = Curves.easeInOut.transform(animation.value);
              //       final scale = lerpDouble(1, 1.05, animValue);
              //       return Transform.scale(
              //         scale: scale,
              //         child: child,
              //       );
              //     },
              //   );
              // },
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
    );
  }
}
