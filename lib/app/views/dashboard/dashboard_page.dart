// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/controllers/dashboard/dashboard_controller.dart';
import 'package:asocapp/app/views/dashboard/articles_list_view.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: true,
          title: const Text("Articles"),
        ),
        body: Obx(() => dashboardController.loading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ],
              )
            : const ArticlesListView()),
      ),
    );
  }
}
