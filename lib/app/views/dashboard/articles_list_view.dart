import 'package:asocapp/app/apirest/api_models/api_models.dart';
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
    super.key,
  });

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
      child: Obx(() {
        return FutureBuilder(
          future: articleController.getArticlesPublicatedList(), // getArticlesPublicatedList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return EglArticleListTile(
                    index: index,
                    leadingImage: snapshot.data[index].coverImageArticle.src,
                    title: snapshot.data[index].titleArticle,
                    subtitle: snapshot.data[index].abstractArticle,
                    category: snapshot.data[index].categoryArticle,
                    subcategory: snapshot.data[index].subcategoryArticle,
                    logo: '',
                    trailingImage: '',
                    onTap: () async {
                      Article article = await articleController.getArticlePublicated(snapshot.data[index]);
                      IArticleArguments args = IArticleArguments(
                        article,
                      );
                      Get.to(() => ArticlePage(articleArguments: args));
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
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }
}
