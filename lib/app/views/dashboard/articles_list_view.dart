import 'package:asocapp/app/controllers/article/article_controller.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_page.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticlesListView extends StatefulWidget {
  const ArticlesListView({
    Key? key,
  }) : super(key: key);

  @override
  State<ArticlesListView> createState() => _ArticlesListViewState();
}

class _ArticlesListViewState extends State<ArticlesListView> {
  ArticleController articleController = Get.put(ArticleController());

  String languageTo = 'es';

  @override
  void initState() {
    super.initState();

    languageTo = articleController.languageUser;

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Utils.eglLogger('e', 'isNotificationAllowed: not isAllowed');
        showDialog(
          context: context,
          builder: (context) {
            // Utils.eglLogger('e', 'isNotificationAllowed: AlertDialog');
            return AlertDialog(
              title: const Text('Allow notifications'),
              content: const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
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
                    AwesomeNotifications().requestPermissionToSendNotifications();
                    Navigator.pop(context);
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
        );
        //******** if */
      }
    });

    // getArticleList().then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    // final Logger logger = Logger();
    // List<TextEditingController> titleController = [];

    return RefreshIndicator(
      displacement: 40.0,
      strokeWidth: 4,
      onRefresh: articleController.getArticles,
      child: Obx(() => FutureBuilder(
          future: articleController.getArticlesPublicatedList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                // separatorBuilder: (context, index) {
                //   return const Divider(
                //     height: 1.0,
                //   );
                // },
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return EglArticleListTile(
                    leadingImage: snapshot.data[index].coverImageArticle.src,
                    title: snapshot.data[index].titleArticle,
                    subtitle: snapshot.data[index].abstractArticle.length > 100
                        ? '   ${snapshot.data[index].abstractArticle.substring(0, 96)} ...'
                        : '   ${snapshot.data[index].abstractArticle}',
                    category: snapshot.data[index].categoryArticle,
                    subcategory: snapshot.data[index].subcategoryArticle,
                    logo: '',
                    trailingImage: '',
                    onTap: () {
                      IArticleArguments args = IArticleArguments(
                        snapshot.data[index],
                      );
                      Get.to(ArticlePage(articleArguments: args));
                    },
                    onTapCategory: () {
                      // Utils.eglLogger('i', 'link: ${snapshot.data[index].categoryArticle}');
                    },
                    onTapSubcategory: () {
                      // Utils.eglLogger('i', 'link: ${snapshot.data[index].categoryArticle}/${snapshot.data.subcategoryArticle}');
                    },
                    color: AppColors.otpHintColor,
                    gradient: AppColors.otpBackgroundColor,
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
