import 'package:asocapp/app/controllers/users/list_users_controller.dart';
import 'package:asocapp/app/views/users/user_list_view.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({super.key});

  @override
  State<ListUsersPage> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  final ListUsersController listUsersController = Get.put(ListUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EglAppBar(
        showBackArrow: true,
        title: "tUserList".tr,
      ),
      body: Obx(
        () => Container(
          color: Colors.blueGrey.shade100,
          height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.blue), // Un borde azul
          //     // Otros estilos de decoración aquí...
          //   ),
          child: listUsersController.loading
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
              : const UserListView(),
        ),
      ),
    );
  }
}
