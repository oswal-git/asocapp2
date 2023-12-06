// ignore_for_file: public_member_api_docs, sort_constructors_first
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
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.note_add,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
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
