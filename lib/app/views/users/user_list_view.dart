import 'package:asocapp/app/controllers/users/list_users_controller.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  ListUsersController listUsersController = Get.put(ListUsersController());

  @override
  Widget build(BuildContext context) {
    listUsersController.loading = false;
    return ListView.builder(
      itemCount: listUsersController.users.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 80.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: listUsersController.getImageWidget2(listUsersController.users[index].avatarUser),
                    ),
                  ),
                ),
                //   color: Colors.green,
                // child: CircleAvatar(
                //   backgroundImage: listUsersController.getImageWidget(listUsersController.users[index].avatarUser),
                //   //   radius: 10.0,
                //   radius: 20,
                // ),
                // ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: 80.0,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listUsersController.users[index].longNameAsociation,
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 14.0,
                            ),
                          ),
                          5.ph,
                          Text(
                            listUsersController.users[index].userNameUser,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          2.ph,
                          Text(
                            listUsersController.users[index].emailUser,
                            style: const TextStyle(
                              fontSize: 12.0,
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
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listUsersController.users[index].statusUser,
                            style: TextStyle(
                              color: listUsersController.users[index].statusUser == 'suspendido'
                                  ? Colors.yellow.shade800
                                  : listUsersController.users[index].statusUser == 'activo'
                                      ? Colors.green.shade800
                                      : listUsersController.users[index].statusUser == 'nuevo'
                                          ? Colors.grey.shade500
                                          : listUsersController.users[index].statusUser == 'baja'
                                              ? Colors.red.shade800
                                              : Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            listUsersController.users[index].profileUser,
                            style: TextStyle(
                              //   color: Colors.grey[600],
                              color: listUsersController.users[index].profileUser == 'admin'
                                  ? Colors.red.shade800
                                  : listUsersController.users[index].profileUser == 'editor'
                                      ? Colors.yellow.shade900
                                      : listUsersController.users[index].profileUser == 'asociado'
                                          ? Colors.green.shade800
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
