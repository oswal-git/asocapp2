// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/item_article_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    Key? key,
    required this.articleArguments,
  }) : super(key: key);

  final IArticleArguments articleArguments;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final SessionService session = Get.put<SessionService>(SessionService());
  final EglTranslatorAiService _translator = EglTranslatorAiService();

  bool loading = true;
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController abstractController = TextEditingController(text: '');
  String languageTo = '';

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.articleArguments.article.titleArticle);
    abstractController = TextEditingController(text: widget.articleArguments.article.abstractArticle);

    languageTo = session.userConnected.languageUser;

    if (languageTo != 'es') {
      _translator.translate(widget.articleArguments.article.titleArticle, languageTo).then((value) {
        if (value.text.trim() != '') titleController = TextEditingController(text: value.text.trim());
        return _translator.translate(widget.articleArguments.article.abstractArticle, languageTo);
      }).then((value) {
        if (value.text.trim() != '') abstractController = TextEditingController(text: value.text.trim());
        loading = false;
        setState(() {});
      });
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String translatTitle = '';

    return Scaffold(
      // drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text(
          'tArticles'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: loading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                    child: CircularProgressIndicator(
                        // color: Colors.white,
                        )),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            titleController.text,
                            textAlign: TextAlign.center,
                            style: AppTheme.headline4.copyWith(
                              height: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Image.network(
                                widget.articleArguments.article.avatarUser,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.articleArguments.article.nameUser} ${widget.articleArguments.article.lastNameUser}',
                                style: AppTheme.bodyText2.copyWith(
                                  fontSize: 10,
                                  height: 0.0,
                                ),
                              ),
                              2.ph,
                              Text(
                                '${'lDate'.tr}: ${DateFormat('fDateFormat'.tr).format(DateTime.parse(widget.articleArguments.article.effectiveDateArticle))}',
                                style: AppTheme.bodyText2.copyWith(
                                  fontSize: 9,
                                  height: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      children: [
                        Image.network(
                          widget.articleArguments.article.coverImageArticle.src,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.justify,
                            '   ${abstractController.text}',
                            style: AppTheme.bodyText2.copyWith(
                              // height: 2.0,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.articleArguments.article.itemsArticle.isNotEmpty)
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: widget.articleArguments.article.itemsArticle.map((item) {
                          return ItemArticleWidget(item: item);
                        }).toList())),
                ],
              ),
      ),
    );
  }
}
