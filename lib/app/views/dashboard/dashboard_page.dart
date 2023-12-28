// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/new_article_page.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:asocapp/app/widgets/button_widgets/egl_check_button_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asocapp/app/controllers/dashboard/dashboard_controller.dart';
import 'package:asocapp/app/views/dashboard/articles_list_view.dart';
import 'package:asocapp/app/widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController dashboardController = Get.put(DashboardController());
  final SessionService session = Get.put<SessionService>(SessionService());

//   @override
//   void initState() {
//     super.initState();
//     dashboardController.isLogin();
//   }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(
        () => Scaffold(
          extendBodyBehindAppBar: false,
          drawer: const NavBar(),
          appBar: EglAppBar(
            //   elevation: 5,
            title: "tArticles".tr,
            //   titleWidget: Text("tArticles".tr),
            //   leadingWidget: const Icon(Icons.menu),
            //   hasDrawer: false,
            // toolbarHeight: 80,
            showBackArrow: false,
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
            actions: [
              if (session.userConnected.profileUser == 'admin' && session.checkEdit)
                EglCircleIconButton(
                  color: EglColorsApp.iconColor,
                  backgroundColor: EglColorsApp.backgroundIconColor,
                  icon: Icons.note_add, // Cambiar a tu icono correspondiente
                  size: 30,
                  onPressed: () {
                    IArticleArguments args = IArticleArguments(
                      hasArticle: false,
                      ArticleUser.clear(),
                    );
                    Get.to(() => NewArticlePage(articleArguments: args));
                  },
                ),
              10.pw,
              if (session.userConnected.profileUser == 'admin')
                EglCheckboxButton(
                  isChecked: session.checkEdit,
                  width: 60.0,
                  height: 30.0,
                  onChanged: (value) async {
                    if (value) {
                      await Future.delayed(const Duration(milliseconds: 250));
                    }
                    session.checkEdit = value;
                  },
                ),
              5.pw,
            ],
          ),
          body: Obx(() => dashboardController.loading
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: ArticlesListView(),
                )),
        ),
      ),
    );
  }
}
