// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/services/egl_translator_ai_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/services/session_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ItemArticleWidget extends StatefulWidget {
  const ItemArticleWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemArticle item;

  @override
  State<ItemArticleWidget> createState() => _ItemArticleWidgetState();
}

class _ItemArticleWidgetState extends State<ItemArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 == 0) Expanded(child: TextItem(text: widget.item.textItemArticle)),
        if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 == 0) 2.pw,
        if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 == 0) ImageItem(image: widget.item.imageItemArticle),
        if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 != 0) ImageItem(image: widget.item.imageItemArticle),
        if (widget.item.imageItemArticle.src != '' && widget.item.idItemArticle % 2 != 0) 2.pw,
        if (widget.item.textItemArticle != '' && widget.item.idItemArticle % 2 != 0) Expanded(child: TextItem(text: widget.item.textItemArticle)),
      ],
    );
  }
}

class TextItem extends StatefulWidget {
  const TextItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  State<TextItem> createState() => _TextItemState();
}

class _TextItemState extends State<TextItem> {
  SessionService session = Get.put<SessionService>(SessionService());

  final EglTranslatorAiService _translator = EglTranslatorAiService();
  TextEditingController textController = TextEditingController(text: '');
  String languageTo = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.text);

    if (languageTo != 'es' && widget.text != '') {
      languageTo = session.userConnected.languageUser;
      _translator.translate(widget.text, languageTo).then((value) {
        if (value.text.trim() != '') textController = TextEditingController(text: value.text.trim());
        loading = false;
        setState(() {});
      });
    } else {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(
                // color: Colors.white,
                ))
        : Html(
            data: '   ${textController.text}',
            style: {
              'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(12), lineHeight: const LineHeight(1.5)),
            },
          );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.image,
  }) : super(key: key);

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
