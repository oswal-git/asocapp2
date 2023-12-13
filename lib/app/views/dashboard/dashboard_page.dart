// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/new_article_page.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
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
      child: Scaffold(
        extendBodyBehindAppBar: false,
        drawer: const NavBar(),
        appBar: EglAppBar(
          //   elevation: 5,
          title: "tArticles".tr,
          //   titleWidget: Text("tArticles".tr),
          //   leadingWidget: const Icon(Icons.menu),
          //   hasDrawer: false,
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
            if (session.userConnected.profileUser == 'admin')
              GestureDetector(
                onTap: () {
                  Get.to(() => const NewArticlePage());
                },
                child: Card(
                  //   color: Colors.tealAccent[400],
                  color: EglColorsApp.backGroundBarColor,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.note_add,
                      color: Colors.indigo[900],
                      size: 22,
                    ),
                  ),
                ),
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
            : const ArticlesListView()),
      ),
    );
  }
}
