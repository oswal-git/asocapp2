// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EditItemArticle extends StatefulWidget {
  const EditItemArticle({
    super.key,
    required this.itemArticle,
    this.onPressed,
  });

  final ItemArticle itemArticle;
  final ValueChanged<ImageArticle>? onPressed;

  @override
  State<EditItemArticle> createState() => _EditItemArticleState();
}

class _EditItemArticleState extends State<EditItemArticle> {
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());

  @override
  Widget build(BuildContext context) {
    // ItemArticle item = articleEditController.newArticleItems[widget.itemIndex];

    return Column(
      children: [
        // text
        EglInputMultiLineField(
          focusNode: null,
          nextFocusNode: null,
          currentValue: widget.itemArticle.textItemArticle,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          iconLabel: Icons.person_pin,
          // ronudIconBorder: true,
          labelText: '',
          hintText: 'hTextItemArticle'.tr,
          maxLines: null,
          maxLength: 2000,
          // icon: Icons.person_pin,
          onChanged: (value) {
            widget.itemArticle.textItemArticle = value;
            articleEditController.newArticleItems.map((item) {
              if (item.idItemArticle == widget.itemArticle.idArticleItemArticle) {
                item.textItemArticle = value;
                return item;
              }
              return item;
            });
          },
          onValidator: (value) {
            return null;
          },
        ),
        // Imagen
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
            image: widget.itemArticle.imageItemArticle,
            defaultImage: EglImagesPath.appCoverDefault,
            isEditable: true,
            onChange: (ImageArticle image) {
              // Lógica para recuperar la imagen por defecto
              widget.itemArticle.imageItemArticle = image.copyWith();
              articleEditController.newArticleItems.map((item) {
                if (item.idItemArticle == widget.itemArticle.idArticleItemArticle) {
                  item.imageItemArticle = image.copyWith();
                  return item;
                }
                return item;
              });
              EglHelper.eglLogger('i', 'onPressedDefault: ${widget.itemArticle.imageItemArticle.toString()}');
            },
            onPressedDefault: (ImageArticle image) {
              // Lógica para recuperar la imagen por defecto
              widget.itemArticle.imageItemArticle = image.copyWith();
              articleEditController.newArticleItems.map((item) {
                if (item.idItemArticle == widget.itemArticle.idArticleItemArticle) {
                  item.imageItemArticle = image.copyWith();
                  return item;
                }
                return item;
              });
              EglHelper.eglLogger('i', 'onPressedDefault: ${widget.itemArticle.imageItemArticle.toString()}');
            },
            onPressedRestore: (ImageArticle image) {
              // Lógica para restaurar la imagen inicial
              widget.itemArticle.imageItemArticle = image.copyWith();
              articleEditController.newArticleItems.map((item) {
                if (item.idItemArticle == widget.itemArticle.idArticleItemArticle) {
                  item.imageItemArticle = image.copyWith();
                  return item;
                }
                return item;
              });
              EglHelper.eglLogger('i', 'onPressedRestore: ${widget.itemArticle.imageItemArticle.toString()}');
            },
          ),
        ),
      ],
    );
  }
}
