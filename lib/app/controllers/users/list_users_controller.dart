import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/repositorys.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apirest/api_models/api_models.dart';

class ListUsersController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
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
          EglHelper.toastMessage(httpResult.error.toString());
          _loading.value = false;
          return users;
        }
      }

      if (httpResult.error!.data == 'Expired token') {
        EglHelper.showPopMessage(
          _context!,
          'mExpiredtoken'.tr,
          'mLoginIn'.tr,
          title2: '',
          message2: '',
          styleMessage: const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
          edgeInsetsPop: const EdgeInsets.fromLTRB(10, 150, 10, 20),
          textButton: 'bAccept'.tr,
          avatarUser: '',
          styleAvatarUser: StyleAvatarUser().copyWith(),
          edgeInsetsButton: const EdgeInsets.fromLTRB(32.0, 6.0, 32.0, 16.0),
          fontSizeButton: 40.0,
          onPressed: () {
            session.exitSession();
            Get.offAll(() => const LoginPage());
            // Navigator.of(context).pop();
          },
        );
      } else {
        EglHelper.popMessage(
            //   _context!, MessageType.info, 'Actualización no realizada', 'No se han podido actualizar los datos del usuario');
            _context!,
            MessageType.info,
            'mNoRefresh'.tr,
            httpResult.error?.data);
      }
    }
    _loading.value = false;
    return users;
  }

  Future<void> updateListUsers(UserItem userItem) async {
    List<UserItem> usersTemp = _users;

    usersTemp = _users.map((e) {
      if (e.idUser == userItem.idUser) {
        e.profileUser = userItem.profileUser;
        e.statusUser = userItem.statusUser;
        e.dateUpdatedUser = userItem.dateUpdatedUser;
      }
      return e;
    }).toList();

    _users.value = usersTemp;
    _users.refresh();
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
      return ClipOval(
        child: SizedBox(
          child: Image.asset(
            'assets/images/icons_user_profile_circle.png',
            //   fit: BoxFit.cover,
            color: Colors.amberAccent[700],
          ),
        ),
      );
    } else {
      return ClipOval(
        child: SizedBox(
          child: Image.network(
            imageAvatar,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
