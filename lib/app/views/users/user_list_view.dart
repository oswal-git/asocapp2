import 'package:asocapp/app/controllers/users/list_users_controller.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/users/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apirest/api_models/api_models.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  ListUsersController listUsersController = Get.put(ListUsersController());

  List<dynamic> listUserStatus = UserStatus.getListUserStatus();
  List<dynamic> listUserProfiles = UserProfiles.getListUserProfiles();

  @override
  Widget build(BuildContext context) {
    listUsersController.loading = false;
    return ListView.builder(
      itemCount: listUsersController.users.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        UserItem user = listUsersController.users[index];

        String staustUserTr = listUserStatus.firstWhere((element) => user.statusUser == element['status'])['name'];
        String profileUserTr = listUserProfiles.firstWhere((element) => user.profileUser == element['profile'])['name'];

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: GestureDetector(
            onTap: () async {
              final resultado = await Get.to(() => UserPage(user: user));
              // final resultado = await navigator?.push(MaterialPageRoute(builder: (contect) => UserPage(user: user)));
              if (resultado != null) {
                user = resultado;
                await listUsersController.updateListUsers(user);

                setState(() {});
              }
            },
            child: Card(
              elevation: 5.0,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent), // Un borde azul
                          // Otros estilos de decoración aquí...
                        ),
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                          child: listUsersController.getImageWidget2(user.avatarUser),
                        ),
                      ),
                    ),
                    //   color: Colors.green,
                    // child: CircleAvatar(
                    //   backgroundImage: listUsersController.getImageWidget(user.avatarUser),
                    //   //   radius: 10.0,
                    //   radius: 20,
                    // ),
                    // ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          height: 100.0,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.longNameAsociation,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 14.0,
                                ),
                              ),
                              5.ph,
                              Text(
                                user.userNameUser,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              2.ph,
                              Text(
                                user.emailUser,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              5.ph,
                              Text(
                                staustUserTr,
                                style: TextStyle(
                                  color: user.statusUser == 'suspendido'
                                      ? Colors.yellow.shade800
                                      : user.statusUser == 'activo'
                                          ? Colors.green.shade800
                                          : user.statusUser == 'nuevo'
                                              ? Colors.grey.shade500
                                              : user.statusUser == 'baja'
                                                  ? Colors.red.shade800
                                                  : Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              30.ph,
                              //   Text(
                              //     staustUserTr,
                              //     style: TextStyle(
                              //       color: user.statusUser == 'suspendido'
                              //           ? Colors.yellow.shade800
                              //           : user.statusUser == 'activo'
                              //               ? Colors.green.shade800
                              //               : user.statusUser == 'nuevo'
                              //                   ? Colors.grey.shade500
                              //                   : user.statusUser == 'baja'
                              //                       ? Colors.red.shade800
                              //                       : Colors.grey,
                              //       fontSize: user.statusUser.length < 7 ? 14.0 : 10.0,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //   ),
                              Text(
                                profileUserTr,
                                style: TextStyle(
                                  //   color: Colors.grey[600],
                                  color: user.profileUser == 'admin'
                                      ? Colors.red.shade800
                                      : user.profileUser == 'editor'
                                          ? Colors.yellow.shade900
                                          : user.profileUser == 'asociado'
                                              ? Colors.green.shade800
                                              : Colors.grey,
                                  fontSize: profileUserTr.length < 9
                                      ? 14.0
                                      : profileUserTr.length < 10
                                          ? 13.0
                                          : 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
