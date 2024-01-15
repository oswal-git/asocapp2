// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/widgets/widgets.dart';
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
    bool haveText = widget.item.textItemArticle != '';
    bool haveImage = widget.item.imageItemArticle.src != '' && !widget.item.imageItemArticle.isDefault;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        2.ph,
        if (haveText) TextItem(text: widget.item.textItemArticle),
        if (haveText && haveImage) 2.ph,
        if (haveImage) ImageItem2(image: widget.item.imageItemArticle),
        10.ph,
      ],
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
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      duration: 1.seconds,
      child: Container(
        // width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.symmetric(horizontal: 15.00),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
          // border: Border.all(
          //   color: Colors.transparent, // color del borde
          //   width: 2.0, // ancho del borde
          // ),
        ),
        child: EglImageWidget(
          image: image,
          defaultImage: EglImagesPath.appCoverDefault,
          isEditable: false,
          canDefault: false,
          onPressedDefault: (_) {},
          onPressedRestore: (_) {},
        ),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        // border: Border.all(
        //   width: 1.0,
        //   color: Colors.red,
        // ),
      ),
      child: Html(
        data: '   $text',
        style: {
          'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(12), lineHeight: const LineHeight(1.5)),
        },
      ),
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
