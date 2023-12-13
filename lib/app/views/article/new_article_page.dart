import 'package:asocapp/app/views/article/article_data_page.dart';
import 'package:asocapp/app/views/article/article_edition_page.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

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
          leadingWidget: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            );
          }),
          bottom: TabBar(
            controller: _tabs.controller,
            tabs: _tabs.articleTabs,
          ),
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
