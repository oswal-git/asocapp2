// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/new_article_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asocapp/app/controllers/dashboard/dashboard_controller.dart';
import 'package:asocapp/app/views/dashboard/articles_list_view.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController dashboardController = Get.put(DashboardController());
  final SessionService session = Get.put<SessionService>(SessionService());
  EglImagesPath eglImagesPath = EglImagesPath();

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
                // Nuevo artículo
                EglCircleIconButton(
                  color: EglColorsApp.iconColor,
                  backgroundColor: EglColorsApp.backgroundIconColor,
                  icon: Icons.note_add, // Cambiar a tu icono correspondiente
                  size: 25,
                  onPressed: () {
                    IArticleArguments args = IArticleArguments(
                      hasArticle: false,
                      ArticleUser.clear(),
                    );
                    Get.to(() => NewArticlePage(articleArguments: args));
                  },
                ),
              10.pw,
              if (session.userConnected.profileUser == 'admin' &&
                  session.isExpired &&
                  session.listUserMessages.isNotEmpty &&
                  session.toReadmessages > 0)
                // Campanita con Messages,
                EglCircleIconButton(
                    text: session.listUserMessages.isEmpty ? '' : session.toReadmessages.toString(),
                    color: EglColorsApp.iconColor,
                    backgroundColor: EglColorsApp.transparent,
                    icon: Icons.notifications_rounded, // Cambiar a tu icono correspondiente
                    size: 30,
                    onPressed: () {
                      if (session.listUserMessages.isNotEmpty) {
                        Get.bottomSheet(
                          isScrollControlled: false,
                          backgroundColor: Colors.white,
                          barrierColor: Colors.blue.withOpacity(.5),
                          elevation: 20.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Lista de Mensajes',
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Expanded(
                                    child: Obx(
                                      () => ListView.separated(
                                        itemCount: session.listUserMessages.length,
                                        separatorBuilder: (_, __) => const Divider(
                                          color: Colors.black45,
                                          height: 2,
                                        ),
                                        itemBuilder: (context, index) {
                                          final message = session.listUserMessages[index];

                                          return Dismissible(
                                            key: UniqueKey(),
                                            background: Container(
                                              color: Colors.red[400],
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(left: 16.0),
                                              child: const Icon(Icons.delete, color: Colors.white),
                                            ),
                                            secondaryBackground: Container(
                                              color: Colors.green,
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: const Icon(Icons.check, color: Colors.white),
                                            ),
                                            onDismissed: (direction) {
                                              if (direction == DismissDirection.startToEnd) {
                                                // Borrar mensaje
                                                session.listUserMessages.removeAt(index);
                                              }
                                            },
                                            confirmDismiss: (direction) async {
                                              if (direction == DismissDirection.endToStart) {
                                                // Marcar como leído
                                                session.checkUserMessage = index;
                                                // setState(() {
                                                // });
                                                return false;
                                              }
                                              return true;
                                            },
                                            child: BuildMessageListTilte(message: message),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              if (session.userConnected.profileUser == 'admin' && !session.isExpired)
                // Check edit button
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

class BuildMessageListTilte extends StatelessWidget {
  const BuildMessageListTilte({
    super.key,
    required this.message,
  });

  final UserMessages message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        message.isRead ? Icons.check_circle_outline : Icons.radio_button_unchecked,
        color: message.isRead ? Colors.green : Colors.red,
      ),
      title: Text(message.text),
      subtitle: Text(DateFormat('fDateFormat'.tr).format(DateTime.parse(message.date))),
      // Text(message.isRead ? 'Leído' : 'No leído'),
    );
  }
}
