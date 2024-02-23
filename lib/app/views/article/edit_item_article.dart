// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';

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

  Color toolbarColor = Colors.grey.shade200;
  bool hasFocus = false;
  String textItem = '';

  int minLength = 0;
  int maxLength = 99999;
  String textValidate = '';

  @override
  void initState() {
    super.initState();

    // Accede a itemArticle y asigna su valor a textItem
    textItem = widget.itemArticle.textItemArticle;
  }

  @override
  Widget build(BuildContext context) {
    // ItemArticle item = articleEditController.newArticleItems[widget.itemIndex];

    return Column(
      // scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      children: [
        // text
        Container(
          margin: const EdgeInsets.only(bottom: 5.0, left: 5.0),
          padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
            border: Border(
                bottom: BorderSide(
              color: Colors.grey, // color del borde
              width: 2.0, // ancho del borde
            )),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Section ${widget.itemArticle.idItemArticle}',
                style: TextStyle(fontSize: 14, color: Colors.indigo[900]),
              ),
              EglCircleIconButton(
                // key: UniqueKey(),
                backgroundColor: Colors.transparent,
                icon: Icons.edit, // Relojito hacia atrás
                size: 20.0,
                onPressed: () async {
                  await EglHelper.editTextField(
                    context,
                    title: 'Section',
                    text: widget.itemArticle.textItemArticle,
                    toolbarPos: false,
                    height: 1000,
                    maxCaracters: 0,
                    onValidate: validateText,
                    onUpdate: (String txtSalida) {
                      if (widget.itemArticle.textItemArticle != txtSalida) {
                        widget.itemArticle.textItemArticle = txtSalida;
                        textItem = widget.itemArticle.textItemArticle;
                        articleEditController.newArticleItems.map((item) {
                          if (item.idItemArticle == widget.itemArticle.idArticleItemArticle) {
                            item.textItemArticle = txtSalida;
                            return item;
                          }
                          return item;
                        });
                        setState(() {});
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // Text title
        Html(
          data: '   $textItem',
          style: const {
            // 'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(16), lineHeight: const LineHeight(1.5)),
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

  String validateText(String text) {
    if (text.isEmpty && minLength > 0) {
      textValidate = 'Introduzca el título del artículo';
    } else if (text.length < minLength) {
      textValidate = 'El título ha de tener $minLength carácteres como mínimo ';
    } else if (text.length > maxLength) {
      textValidate = 'El título ha de tener $maxLength carácteres como máximo ';
      // controller.getTe
    } else {
      textValidate = '';
    }
    return textValidate;
  }

// end class
}
