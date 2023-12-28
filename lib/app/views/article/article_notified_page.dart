// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/apirest/api_models/article_model.dart';
import 'package:asocapp/app/controllers/article/article_notified_controller.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';

import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/item_article_widget.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleNotifiedPage extends StatefulWidget {
  const ArticleNotifiedPage({
    super.key,
    required this.articleNotifiedArguments,
  });

  final IArticleNotifiedArguments articleNotifiedArguments;

  @override
  State<ArticleNotifiedPage> createState() => _ArticleNotifiedPageState();
}

class _ArticleNotifiedPageState extends State<ArticleNotifiedPage> {
  final articleNotifiedController = Get.find<ArticleNotifiedController>();

  ArticleUser article = ArticleUser.clear();

  Future<ArticleUser> getSingleArticle() async {
    return articleNotifiedController.getSingleArticle(widget.articleNotifiedArguments.idArticle);
  }

  @override
  void initState() {
    super.initState();

    getSingleArticle().then((ArticleUser value) {
      if (value.idArticle == 0) {
        articleNotifiedController.exitSession();
        Get.to(() => LoginPage);
      }

      setState(() {
        article = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: const Text("Articles"),
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
                      article.titleArticle,
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
                        child: article.avatarUser != ''
                            ? Image.network(
                                article.avatarUser,
                                width: 30,
                              )
                            : null,
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
                          '${article.nameUser} ${article.lastNameUser}',
                          style: AppTheme.bodyText2.copyWith(
                            fontSize: 10,
                            height: 0.0,
                          ),
                        ),
                        2.ph,
                        Text(
                          'Fecha: ${article.effectiveDateArticle}',
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
              child: article.coverImageArticle.src != ''
                  ? Wrap(
                      children: [
                        Image.network(
                          article.coverImageArticle.src,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.justify,
                      '   ${article.abstractArticle}',
                      style: AppTheme.bodyText2.copyWith(
                        // height: 2.0,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (article.itemsArticle.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: article.itemsArticle.map((item) {
                    return ItemArticleWidget(item: item);
                  }).toList())),
          ],
        ),
      ),
    );
  }
}
