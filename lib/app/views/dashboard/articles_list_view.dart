import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_controller.dart';
import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_page.dart';
import 'package:asocapp/app/views/article/new_article_page.dart';
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
  final SessionService session = Get.put<SessionService>(SessionService());

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
      displacement: 80.0,
      strokeWidth: 4,
      edgeOffset: 40,
      onRefresh: articleController.getArticles,
      child: Obx(() {
        return FutureBuilder(
          future: session.checkEdit
              ? articleController.getAllArticlesList()
              : articleController.getArticlesPublicatedList(), // getArticlesPublicatedList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      EglArticleListTile(
                        index: index,
                        leadingImage: snapshot.data[index].coverImageArticle.src,
                        title: snapshot.data[index].titleArticle,
                        subtitle: snapshot.data[index].abstractArticle,
                        category: snapshot.data[index].categoryArticle,
                        subcategory: snapshot.data[index].subcategoryArticle,
                        state: snapshot.data[index].stateArticle,
                        colorState: session.checkEdit ? EglColorsApp.primaryTextTextColor : Colors.transparent,
                        logo: '',
                        trailingImage: '',
                        onTap: () async {
                          ArticleUser article = await articleController.getArticleUserPublicated(snapshot.data[index]);
                          IArticleUserArguments args = IArticleUserArguments(
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
                        backgroundColor: articleController.getColorState(snapshot.data[index]),
                        colorBorder: EglColorsApp.borderTileArticleColor,
                      ),
                      if (session.userConnected.profileUser == 'admin' &&
                          session.checkEdit &&
                          session.userConnected.idAsociationUser == snapshot.data[index].idAsociationArticle)
                        Positioned(
                          top: 4.0, // Ajusta según sea necesario
                          left: 20.0, // Ajusta según sea necesario
                          child: EglCircleIconButton(
                            color: EglColorsApp.iconColor,
                            backgroundColor: EglColorsApp.backgroundIconColor,
                            icon: Icons.edit_document, // Cambiar a tu icono correspondiente
                            size: 20,
                            onPressed: () async {
                              Article article = snapshot.data[index] as Article;
                              IArticleArguments args = IArticleArguments(
                                article,
                              );
                              Get.to(() => NewArticlePage(articleArguments: args));
                            },
                          ),
                        ),
                      if (session.userConnected.profileUser == 'admin' &&
                          session.checkEdit &&
                          session.userConnected.idAsociationUser == snapshot.data[index].idAsociationArticle)
                        Positioned(
                          top: 4.0, // Ajusta según sea necesario
                          left: 60.0, // Ajusta según sea necesario
                          child: EglCircleIconButton(
                            color: EglColorsApp.iconColor,
                            backgroundColor: EglColorsApp.backgroundIconColor,
                            icon: Icons.delete, // Cambiar a tu icono correspondiente
                            size: 20,
                            onPressed: () {
                              // Lógica para recuperar la imagen por defecto
                            },
                          ),
                        ),
                    ],
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
              return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        );
      }),
    );
  }
}
