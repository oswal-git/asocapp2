import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_data_page.dart';
import 'package:asocapp/app/views/article/article_edition_page.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewArticlePage extends StatefulWidget {
  NewArticlePage({
    super.key,
    required this.articleArguments,
  }) {
    articleEditController.oldArticle = articleArguments.article.copyWith();
    articleEditController.newArticle = articleArguments.article.copyWith();
    if (articleArguments.hasArticle) {
      articleEditController.imagePropertie.value = Image.network(articleEditController.newArticle.coverImageArticle.src);
    } else {
      articleEditController.oldArticle.coverImageArticle.modify(
        src: EglImagesPath.appIconUserDefault,
        nameFile: EglImagesPath.nameIconUserDefaultProfile,
        isDefault: true,
      );
      articleEditController.newArticle.coverImageArticle.modify(
        src: EglImagesPath.appIconUserDefault,
        nameFile: EglImagesPath.nameIconUserDefaultProfile,
        isDefault: true,
      );

      articleEditController.imagePropertie.value = Image.asset(EglImagesPath.appIconUserDefault);
    }
  }

  final IArticleArguments articleArguments;
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final ArticleDataTabs _tabs = Get.put(ArticleDataTabs());

    return Scaffold(
        appBar: EglAppBar(
          //   elevation: 5,
          title: "tArticle".tr,
          //   titleWidget: Text("tArticles".tr),
          //   leadingWidget: const Icon(Icons.menu),
          //   hasDrawer: false,
          toolbarHeight: 80,
          showBackArrow: true,
          leadingIcon: null,
          leadingOnPressed: () {},
          leadingWidget: null,
          bottom: TabBar(
            controller: _tabs.controller,
            tabs: _tabs.articleTabs,
          ),
          actions: [
            // if (session.userConnected.profileUser == 'admin')
            EglCircleIconButton(
              color: EglColorsApp.iconColor,
              backgroundColor: EglColorsApp.transparent,
              icon: Icons.save, // Cambiar a tu icono correspondiente
              size: 30,
              onPressed: () {},
            ),
            5.pw,
            EglCircleIconButton(
              color: Colors.indigo.shade900,
              backgroundColor: EglColorsApp.transparent,
              icon: Icons.monitor, // Cambiar a tu icono correspondiente
              size: 30,
              onPressed: () {},
            ),
            5.pw,
          ],
        ),
        body: TabBarView(
          controller: _tabs.controller,
          children: [
            const ArticleEditionPage(),
            ArticleDataPage(),
          ],
        ));
  }
}

class ArticleDataTabs extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;

  final List<Tab> articleTabs = <Tab>[
    const Tab(text: "Article editor"),
    const Tab(text: "Article data"),
  ];

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
