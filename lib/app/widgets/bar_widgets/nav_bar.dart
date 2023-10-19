import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:asocapp/app/views/auth/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final SessionService session = Get.put<SessionService>(SessionService());

    return Drawer(
      child: Obx(
        () => ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                ' ${session.userConnected.userNameUser}',
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryTextTextColor,
                ),
              ),
              accountEmail: Text(
                ' ${session.userConnected.shortNameAsoc}',
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryTextTextColor,
                ),
              ),
              currentAccountPicture: InkWell(
                onTap: () {
                  Get.to(const ProfilePage());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.blue.shade900,
                  backgroundImage: session.userConnected.avatarUser == '' ? null : NetworkImage(session.userConnected.avatarUser),
                  radius: 30,
                  child: session.userConnected.userNameUser == ''
                      ? null
                      : session.userConnected.avatarUser == ''
                          ? Text(
                              session.userConnected.userNameUser.substring(0, 2).toUpperCase(),
                              style: const TextStyle(fontSize: 30),
                            )
                          : null,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://thumbs.dreamstime.com/b/vista-del-paisaje-mediterr%C3%A1neo-hermoso-del-mar-y-del-cielo-soleado-67838267.jpg',
                    // 'https://artelista.s3.amazonaws.com/obras/big/6/7/3/4326362245540364.jpg',
                    // 'https://artelista.s3.amazonaws.com/obras/fichas/4/9/3/6821947658369943.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Friends'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Request'),
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Polices'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text('Cambio de contraseña'),
              onTap: () {
                Get.offAll(ChangePage);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () {
                session.exitSession();
                Get.offAll(() => const LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
