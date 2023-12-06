// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/item_article_widget.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    super.key,
    required this.articleArguments,
  });

  final IArticleArguments articleArguments;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final SessionService session = Get.put<SessionService>(SessionService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String translatTitle = '';

    return Scaffold(
      // drawer: const NavBar(),
      appBar: EglAppBar(
        // backgroundColor: Colors.redAccent,
        showBackArrow: true,
        title: 'tArticle'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.articleArguments.article.titleArticle,
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
                      '   ${widget.articleArguments.article.abstractArticle}',
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
