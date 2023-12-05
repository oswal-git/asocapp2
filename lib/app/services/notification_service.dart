import 'dart:async';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/repositorys/articles_repository.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_notified_page.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());

  @pragma("vm:entry-point")
  Future<NotificationService> initialize() async {
    AwesomeNotifications().initialize(
      // null,
      'resource://drawable/res_asociaciones_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'avisos_noticias',
          channelName: 'Avisos de noticias',
          channelDescription: 'Avisos de noticias',
          defaultColor: Colors.tealAccent,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );

    return this;
  }

  @pragma("vm:entry-point")
  static Future<String?> requestUserPermissions(BuildContext context) async {
    String permission = 'nothing';

    // Return the updated list of allowed permissions

    return AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Allow notifications'),
              content: const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Helper.eglLogger('i', 'isNotificationAllowed: Dont\'t Allow');
                    permission = 'not_allow';
                    return;
                  },
                  child: const Text(
                    'Dont\'t Allow',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Helper.eglLogger('i', 'isNotificationAllowed: Allow');
                    AwesomeNotifications().requestPermissionToSendNotifications().then((_) {
                      permission = 'request';
                      return;
                    });
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
            //******* AlertDialog */
          },

          //******* showDialog */
        ).then((_) {
          return permission;
        }).catchError(
          (error, stackTrace) {
            permission = error.toString();
            return permission;
          },
        );
        //******** if */
      } else {
        permission = 'not_allowed';
        return permission;
      }
    }).onError((error, stackTrace) {
      permission = error.toString();
      return permission;
    }).catchError((error, stackTrace) {
      permission = error.toString();
      return permission;
    }).whenComplete(() {
      permission = '$permission -> whenComplete';
      // Helper.eglLogger('e', 'AwesomeNotifications:  $permission');
    }).catchError((error, stackTrace) {
      permission = '$permission -> error in the "finally block"';
      return permission;
    });
  }

  @pragma("vm:entry-point")
  static Future<void> createArticleNotification(dynamic item) async {
    // int idArticle, String titleArticle, String abstractArticle, String longNameAsociation, String coverImageArticle
    // Helper.eglLogger('i', 'NotificationService: createArticleNotification - item:', object: item);
    // Helper.eglLogger('i', 'NotificationService: createArticleNotification: item[idArticle]: ${item["idArticle"].runtimeType}');
    // Helper.eglLogger('i', 'NotificationService: createArticleNotification: item[idArticle]: ${item["idArticle"].toString()}');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: item['idArticle'],
          channelKey: 'avisos_noticias',
          title: '${item['longNameAsociation']} \n${item['titleArticle']}',
          body: item['abstractArticle'],
          bigPicture: item['coverImageArticle'],
          notificationLayout: NotificationLayout.BigPicture,
          payload: {"idArticle": item['idArticle'].toString()}),
    );
    // bigPicture: 'asset://assets/images/eglos_logo.png',
    Helper.eglLogger('i', 'NotificationService: createArticleNotification: fin');
  }

  @pragma("vm:entry-point")
  static Future<bool> setListeners(BuildContext context) async {
    return AwesomeNotifications().setListeners(
      onActionReceivedMethod: (
        ReceivedAction receivedAction,
      ) =>
          NotificationService.onActionReceivedMethod(
        context,
        receivedAction,
      ),
      onNotificationCreatedMethod: (
        ReceivedNotification receivedNotification,
      ) =>
          NotificationService.onNotificationCreatedMethod(
        context,
        receivedNotification,
      ),
      //   onActionNotificationMethod: (
      //     ReceivedNotification receivedNotification,
      //   ) =>
      //       NotificationService.onActionNotificationMethod(
      //     context,
      //     receivedNotification,
      //   ),
      onNotificationDisplayedMethod: (
        ReceivedNotification receivedNotification,
      ) =>
          NotificationService.onNotificationDisplayedMethod(
        context,
        receivedNotification,
      ),
      onDismissActionReceivedMethod: (
        ReceivedAction receivedAction,
      ) =>
          NotificationService.onDismissActionReceivedMethod(
        context,
        receivedAction,
      ),
    );
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(BuildContext context, ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    Helper.eglLogger('w', 'onActionReceivedMethod /dashboard push ${receivedAction.id!.toString()}');
    Helper.eglLogger('w', 'onActionReceivedMethod receivedAction.payload ${receivedAction.payload}');
    Helper.eglLogger('w', 'onActionReceivedMethod receivedAction.payload[idArticle] ${receivedAction.payload?['idArticle']}');

    if (receivedAction.channelKey == 'avisos_noticias') {
      // Navigator.pushNamed(
      //   context,
      //   RouteName.article,
      //   arguments: IArticleNotifiedArguments(
      //     receivedAction.id!,
      //   ),
      // );

      if (int.parse(receivedAction.payload?['idArticle'] ?? '0') > 0) {
        IArticleNotifiedArguments args = IArticleNotifiedArguments(
          int.parse(receivedAction.payload?['idArticle'] ?? '0'),
        );
        Get.to(() => ArticleNotifiedPage(articleNotifiedArguments: args));
        //     MyApp.navigatorKey.currentState
        //         ?.pushNamedAndRemoveUntil(RouteName.articleNotified, (route) => (route.settings.name != RouteName.articleNotified) || route.isFirst,
        //             arguments: IArticleNotifiedArguments(
        //               int.parse(receivedAction.payload?['idArticle'] ?? '0'),
        //             ));
      }
    }
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     RouteName.articleNotified,
    //     (route) => route.isFirst,
    //     arguments: IArticleNotifiedArguments(
    //       receivedAction.id!,
    //     ),
    //   );
    // }
    // Navigator.pushNamedAndRemoveUntil(
    //     context, RouteName.articleNotified, (route) => (route.settings.name != RouteName.articleNotified) || route.isFirst,
    //     arguments: IArticleNotifiedArguments(receivedAction.id!));
  }

  /// Use this method to ???
  @pragma("vm:entry-point")
  static Future<void> onActionNotificationMethod(BuildContext context, ReceivedNotification receivedNotification) async {
    // Your code goes here
    Helper.eglLogger('w', 'onActionNotificationMethod');
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(BuildContext context, ReceivedNotification receivedNotification) async {
    // Your code goes here
    Helper.eglLogger('i', 'onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(BuildContext context, ReceivedNotification receivedNotification) async {
    // Your code goes here
    Helper.eglLogger('i', 'onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(BuildContext context, ReceivedAction receivedAction) async {
    // Your code goes here
    Helper.eglLogger('w', 'onDismissActionReceivedMethod');
  }

  Future<Map<dynamic, dynamic>> getPendingNotifyArticlesList() async {
    List<dynamic> list = [];
    List<NotificationArticle> notificationArticleList = [];
    Map<dynamic, dynamic> pending = {
      'list': [],
      'dateUpdatedUser': '',
    };

    try {
      final NotificationArticleListResponse notificationArticleListResponse = await articlesRepository.getPendingNotifyArticlesList();

      // print('Response body: ${result}');
      if (notificationArticleListResponse.status == 200) {
        notificationArticleListResponse.result.records.map((notificationArticle) => notificationArticleList.add(notificationArticle)).toList();

        list = notificationArticleList
            .map((item) => {
                  'idArticle': item.idArticle,
                  'idAsociationArticle': item.idAsociationArticle,
                  'titleArticle': item.titleArticle,
                  'abstractArticle': item.abstractArticle,
                  'coverImageArticle': item.coverImageArticle,
                  'longNameAsociation': item.longNameAsociation,
                  'shortNameAsociation': item.shortNameAsociation,
                })
            .toList();

        pending['list'] = list;
        pending['dateUpdatedUser'] = notificationArticleListResponse.result.dateUpdatedUser;
      }
      // return list;
    } catch (error) {
      // print('Response status: ${response.statusCode}');
      Helper.eglLogger('e', 'ArticlesService -> getPendingNotifyArticlesList -> Response try error: $error');
    }
    return Future.value(pending);
  }

  // End class
}

createUniqueId() {
  return '1';
}
