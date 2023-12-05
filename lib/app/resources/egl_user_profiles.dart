// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class UserProfiles {
  final String profile;
  final String name;

  UserProfiles(
    this.profile,
    this.name,
  );

  static List<UserProfiles> listUserProfiles() {
    return <UserProfiles>[
      UserProfiles('admin', 'cAdmin'),
      UserProfiles('editor', 'cEditor'),
      UserProfiles('asociado', 'cAsociated'),
      UserProfiles('vecino', 'cNeighbour'),
    ];
  }

  static getListUserProfiles() {
    List<UserProfiles> listProfiles = listUserProfiles();

    List<dynamic> res = listProfiles
        .map((profile) => {
              'profile': profile.profile,
              'name': profile.name.tr,
            })
        .toList();
    return res;
  }
}
