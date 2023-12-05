// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class UserStatus {
  final String status;
  final String name;

  UserStatus(
    this.status,
    this.name,
  );

  static List<UserStatus> listUserStatus() {
    return <UserStatus>[
      UserStatus('nuevo', 'cNew'),
      UserStatus('activo', 'cActive'),
      UserStatus('suspendido', 'cSuspended'),
      UserStatus('baja', 'cInactive'),
      UserStatus('eliminado', 'cDeleted'),
    ];
  }

  static getListUserStatus() {
    List<UserStatus> listStatus = listUserStatus();

    List<dynamic> res = listStatus
        .map((status) => {
              'status': status.status,
              'name': status.name.tr,
            })
        .toList();
    return res;
  }
}
