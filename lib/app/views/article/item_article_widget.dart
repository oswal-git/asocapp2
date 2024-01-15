// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:asocapp/app/services/egl_translator_ai_service.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';

class ItemArticleWidget extends StatefulWidget {
  const ItemArticleWidget({
    super.key,
    required this.item,
  });

  final ItemArticle item;

  @override
  State<ItemArticleWidget> createState() => _ItemArticleWidgetState();
}

class _ItemArticleWidgetState extends State<ItemArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 == 0) TextItem(text: widget.item.textItemArticle),
        // if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 == 0) 2.pw,
        // if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 == 0) ImageItem2(image: widget.item.imageItemArticle),
        // if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 != 0) ImageItem2(image: widget.item.imageItemArticle),
        // if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 != 0) 2.pw,
        // if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 != 0) TextItem(text: widget.item.textItemArticle),
        if (widget.item.textItemArticle != '') TextItem(text: widget.item.textItemArticle),
        if (widget.item.textItemArticle != '') 2.pw,
        if (widget.item.imageItemArticle.src != '') ImageItem2(image: widget.item.imageItemArticle),
      ],
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.image,
  });

  final ImageArticle image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        image.src,
        fit: BoxFit.scaleDown,
        width: 100,
      ),
    );
  }
}

class ImageItem2 extends StatelessWidget {
  const ImageItem2({
    super.key,
    required this.image,
  });

  final ImageArticle image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      duration: 1.seconds,
      child: Image.network(
        image.src,
        fit: BoxFit.scaleDown,
        width: 150,
        // color: Colors.indigo,
      ),
    );
  }
}

class TextItem extends StatelessWidget {
  final String text;

  const TextItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '   $text',
      style: {
        'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(12), lineHeight: const LineHeight(1.5)),
      },
    );
  }
}

class TextItemController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
  final EglTranslatorAiService _translator = EglTranslatorAiService();

  TextEditingController textController = TextEditingController(text: '');

  final _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  String languageTo = '';

  @override
  void onInit() {
    super.onInit();
    languageTo = session.userConnected.languageUser;
  }

  void translate(String text) {
    textController = TextEditingController(text: text);

    if (languageTo != 'es' && text != '') {
      _translator.translate(text, languageTo).then((value) {
        if (value.trim() != '') textController = TextEditingController(text: value.trim());
        loading = false;
      }).catchError((error, stackTrace) {
        EglHelper.eglLogger('e', 'translate: $text');
        EglHelper.eglLogger('e', 'translate -> error :$error');
        EglHelper.eglLogger('e', 'translate -> stackTrace :$stackTrace');
        loading = false;
      });
    } else {
      loading = false;
    }
  }
}
