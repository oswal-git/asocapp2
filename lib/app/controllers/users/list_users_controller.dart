import 'package:asocapp/app/repositorys/repositorys.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apirest/api_models/api_models.dart';

class ListUsersController extends GetxController {
  final UserRepository userRepository = Get.put(UserRepository());
  final BuildContext? _context = Get.context;

  final _users = <UserItem>[].obs;
  List<UserItem> get users => _users;
  set users(value) => _users.value = value;

  final _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  @override
  onInit() async {
    super.onInit();
    await refreshUsersList();
  }

  Future<List<UserItem>> refreshUsersList() async {
    HttpResult<UsersListResponse>? httpResult;

    if (_users.isEmpty) {
      httpResult = await userRepository.getAllUsers();

      if (httpResult!.data != null) {
        if (httpResult.statusCode == 200) {
          List<UserItem> records = httpResult.data!.result.records;
          _users.value = [];

          records.map((user) {
            _users.add(user);
          }).toList();
          _loading.value = false;
          return users;
        } else {
          Helper.toastMessage(httpResult.error.toString());
          _loading.value = false;
          return users;
        }
      }
      Helper.popMessage(
          //   _context!, MessageType.info, 'Actualización no realizada', 'No se han podido actualizar los datos del usuario');
          _context!,
          MessageType.info,
          'Actualización no realizada',
          httpResult.error?.data);
    }
    _loading.value = false;
    return users;
  }

  final _imageWidget = Rx<ImageProvider>(const AssetImage('assets/images/icons_user_profile_circle.png'));

  ImageProvider get imageWidget => _imageWidget.value;
  getImageWidget(String imageAvatar) {
    if (imageAvatar == '') {
      // ignore: curly_braces_in_flow_control_structures
      _imageWidget.value = const AssetImage('assets/images/icons_user_profile_circle.png');
    } else {
      _imageWidget.value = NetworkImage(
        imageAvatar,
      );
    }
    return _imageWidget.value;
  }

  final _imageSrc = 'assets/images/icons_user_profile_circle.png'.obs;

  String get imageSrc => _imageSrc.value;
  getImageSrc(String imageAvatar) {
    if (imageAvatar == '') {
      // ignore: curly_braces_in_flow_control_structures
      _imageSrc.value = 'assets/images/icons_user_profile_circle.png';
    } else {
      _imageSrc.value = imageAvatar;
    }
    return _imageSrc.value;
  }

  getImageWidget2(String imageAvatar) {
    if (imageAvatar == '') {
      // ignore: curly_braces_in_flow_control_structures
      return const ClipOval(
        child: SizedBox(
          width: 20,
          height: 20,
          child: Image(
            image: AssetImage('assets/images/icons_user_profile_circle.png'),
            //   fit: BoxFit.cover,
            color: Colors.amberAccent,
          ),
        ),
      );
    } else {
      return ClipOval(
        child: SizedBox(
          width: 20,
          height: 20,
          child: Image.network(
            imageAvatar,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
