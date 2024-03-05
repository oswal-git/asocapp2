import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/api_models/basic_response_model.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_page.dart';
import 'package:asocapp/app/views/article/edit_article_page.dart';
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
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  ArticleUser item = snapshot.data[index];
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      EglArticleListTile(
                        index: index,
                        leadingImage: item.coverImageArticle.src,
                        title: item.titleArticle,
                        subtitle: item.abstractArticle,
                        category: item.categoryArticle,
                        subcategory: item.subcategoryArticle,
                        state: item.stateArticle,
                        colorState: session.checkEdit ? EglColorsApp.primaryTextTextColor : Colors.transparent,
                        logo: '',
                        trailingImage: '',
                        onTap: () async {
                          ArticleUser article = await articleController.getArticleUserPublicated(item);
                          IArticleUserArguments args = IArticleUserArguments(
                            article,
                          );
                          Get.to(() => ArticlePage(articleArguments: args));
                        },
                        onTapCategory: () {
                          // Utils.eglLogger('i', 'link: ${item.categoryArticle}');
                        },
                        onTapSubcategory: () {
                          // Utils.eglLogger('i', 'link: ${item.categoryArticle}/${snapshot.data.subcategoryArticle}');
                        },
                        backgroundColor: articleController.getColorState(item),
                        colorBorder: EglColorsApp.borderTileArticleColor,
                      ),
                      if (session.userConnected.profileUser == 'admin' &&
                          session.checkEdit &&
                          session.userConnected.idAsociationUser == item.idAsociationArticle)
                        Positioned(
                          top: 4.0, // Ajusta según sea necesario
                          left: 20.0, // Ajusta según sea necesario
                          child: EglCircleIconButton(
                            color: EglColorsApp.iconColor,
                            backgroundColor: EglColorsApp.backgroundIconColor,
                            icon: Icons.edit_document, // Cambiar a tu icono correspondiente
                            size: 20,
                            onPressed: () async {
                              Article article = item as Article;
                              IArticleArguments args = IArticleArguments(
                                article,
                              );
                              Get.to(() => EditArticlePage(articleArguments: args));
                            },
                          ),
                        ),
                      if (session.userConnected.profileUser == 'admin' &&
                          session.checkEdit &&
                          session.userConnected.idAsociationUser == item.idAsociationArticle)
                        Positioned(
                          top: 4.0, // Ajusta según sea necesario
                          left: 60.0, // Ajusta según sea necesario
                          child: EglCircleIconButton(
                              color: EglColorsApp.iconColor,
                              backgroundColor: EglColorsApp.backgroundIconColor,
                              icon: Icons.delete, // Cambiar a tu icono correspondiente
                              size: 20,
                              onPressed: () async {
                                EglHelper.showConfirmationPopup(
                                  title: 'Eliminar artículo',
                                  textOkButton: 'Eliminar',
                                  message: 'Seguro que quieres eliminar el artículo ${item.titleArticle}',
                                ).then((value) {
                                  // Manejar el resultado aquí si es nec,esario
                                  if (value != null && value == true) {
                                    // Confirmado
                                    deleteArticle(context, item);
                                  } else {
                                    // Cancelado
                                  }
                                });
                              }),
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
            } else if (snapshot.hasData && !session.thereIsInternetconnection) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No hay conexxión a internet',
                    ),
                    EglRoundButton(
                      onPress: () => articleController.getArticles(),
                      title: 'Intentar de nuevo',
                    )
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () => articleController.getArticles(),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }

  deleteArticle(BuildContext context, ArticleUser item) async {
    HttpResult<BasicResponse>? httpResult = await articleController.deleteArticle(
      item.idArticle,
      item.dateUpdatedArticle,
    );

    if (httpResult!.statusCode == 200) {
      if (context.mounted) {
        EglHelper.popMessage(context, MessageType.info, 'Article deleted', 'Article deleted');
      }
      await articleController.getArticles();
      return;
    } else if (httpResult.statusCode == 400) {
      if (context.mounted) {
        EglHelper.popMessage(context, MessageType.info, '${'mUnexpectedError'.tr}.', httpResult.error?.data);
        EglHelper.eglLogger('e', httpResult.error?.data);
      }
      return;
    } else if (httpResult.statusCode == 404) {
      if (context.mounted) {
        EglHelper.popMessage(context, MessageType.info, '${'mUnexpectedError'.tr}.', '${'mNoScriptAvailable'.tr}.');
        EglHelper.eglLogger('e', httpResult.error?.data);
      }
      return;
    } else {
      if (context.mounted) {
        EglHelper.popMessage(context, MessageType.info, '${'mUnexpectedError'.tr}.', httpResult.error?.data);
        EglHelper.eglLogger('e', httpResult.error?.data);
      }
      return;
    }
  }
}
