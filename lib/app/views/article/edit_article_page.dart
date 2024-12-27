import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/api_models/article_plain_api_model.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_controller.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/article/argument_article_interface.dart';
import 'package:asocapp/app/views/article/article_data_page.dart';
import 'package:asocapp/app/views/article/article_edition_page.dart';
import 'package:asocapp/app/views/article/article_page.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditArticlePage extends StatefulWidget {
  EditArticlePage({
    super.key,
    required this.articleArguments,
  }) {
    articleEditController.oldArticle = articleArguments.article.copyWith();
    articleEditController.newArticle = articleArguments.article.copyWith();
    // articleEditController.oldArticleItems = List<ItemArticle>.from(articleArguments.article.itemsArticle);
    // articleEditController.newArticleItems = List<ItemArticle>.from(articleArguments.article.itemsArticle);

    // articleEditController.oldArticleItems = articleArguments.article.itemsArticle.map((item) => item.copyWith()).toList();
    // articleEditController.newArticleItems = articleArguments.article.itemsArticle.map((item) => item.copyWith()).toList();

    if (articleArguments.hasArticle) {
      articleEditController.isNew = false;
      articleEditController.titleOk = true;
      articleEditController.abstractOk = true;
      // articleEditController.checkIsFormValid();
      // articleEditController.imagePropertie.value = Image.network(articleEditController.newArticle.coverImageArticle.src);
    } else {
      articleEditController.isNew = true;
      int asoc = session.userConnected.idAsociationUser == 0 ? int.parse('9' * 9) : session.userConnected.idAsociationUser;
      articleEditController.oldArticle.modify(
        idAsociationArticle: asoc,
        idUserArticle: session.userConnected.idUser,
      );
      articleEditController.oldArticle.coverImageArticle.modify(
        src: EglImagesPath.appCoverDefault,
        nameFile: EglHelper.getNameFilePath(EglImagesPath.appCoverDefault),
        isDefault: true,
      );

      articleEditController.newArticle.modify(
        idAsociationArticle: asoc,
        idUserArticle: session.userConnected.idUser,
      );
      articleEditController.newArticle.coverImageArticle.modify(
        src: EglImagesPath.appCoverDefault,
        nameFile: EglHelper.getNameFilePath(EglImagesPath.appCoverDefault),
        isDefault: true,
      );

      // articleEditController.imagePropertie.value = Image.asset(EglImagesPath.appIconUserDefault);
    }
  }

  final IArticleArguments articleArguments;
  final ArticleController articleController = Get.put(ArticleController());
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());
  final SessionService session = Get.put(SessionService());

  @override
  State<EditArticlePage> createState() => _EditArticlePageState();
}

class _EditArticlePageState extends State<EditArticlePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final ArticleDataTabs _tabs = Get.put(ArticleDataTabs());

    leadingOnPressed() {
      bool articleChanged = !(widget.articleEditController.newArticle == widget.articleEditController.oldArticle);
      bool itemsChanged =
          !(EglHelper.listsAreEqual(widget.articleEditController.newArticle.itemsArticle, widget.articleEditController.oldArticle.itemsArticle));
      if (articleChanged || itemsChanged) {
        EglHelper.showConfirmationPopup(
          title: 'Descartar modificaciones del artículo',
          textOkButton: 'Descartar',
          message: 'Seguro que quieres descartar los cambios en el artículo ${widget.articleEditController.newArticle.titleArticle}',
        ).then((value) {
          // Manejar el resultado aquí si es nec,esario
          if (value != null && value == true) {
            // Confirmado
            articleChanged ? widget.articleEditController.newArticle = widget.articleEditController.oldArticle.copyWith() : null;
            itemsChanged
                ? widget.articleEditController.newArticle.itemsArticle = EglHelper.copyListItems(widget.articleEditController.oldArticle.itemsArticle)
                // widget.articleEditController.oldArticle.itemsArticle.map((item) => item.copyWith()).toList()
                : null;
            Get.back();
            return;
          } else {
            // Cancelado
            return;
          }
        });
      } else {
        Get.back();
        return;
      }
    }

    createArticle() async {
      ArticlePlain articlePlain = ArticlePlain.fromArticle(article: widget.articleEditController.newArticle);
      ImageArticle imageCoverArticle = widget.articleEditController.newArticle.coverImageArticle;
      EglHelper.eglLogger('i', widget.articleEditController.newArticle.toString());
      EglHelper.eglLogger('i', widget.articleEditController.newArticle.itemsArticle.toString());
      HttpResult<ArticleUserResponse>? httpResult = await widget.articleEditController.createArticle(
        context,
        articlePlain,
        imageCoverArticle,
        widget.articleEditController.newArticle.itemsArticle,
      );
      if (httpResult!.statusCode == 200) {
        if (httpResult.data != null) {
          if (context.mounted) {
            EglHelper.popMessage(context, MessageType.info, 'Article created', widget.articleEditController.newArticle.titleArticle);
          }
          await widget.articleController.getArticles();
          Get.back();
          Get.back();
          return;
        } else {
          EglHelper.toastMessage(httpResult.error.toString());
          return;
        }
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

    modifyArticle() async {
      ArticlePlain articlePlain = ArticlePlain.fromArticle(article: widget.articleEditController.newArticle);
      ImageArticle imageCoverArticle = widget.articleEditController.newArticle.coverImageArticle;
      // EglHelper.eglLogger('i', widget.articleEditController.newArticle.toString());
      // EglHelper.eglLogger('i', widget.articleEditController.newArticleItems.toString());
      HttpResult<ArticleUserResponse>? httpResult = await widget.articleEditController.modifyArticle(
        context,
        articlePlain,
        imageCoverArticle,
        widget.articleEditController.newArticle.itemsArticle,
      );
      if (httpResult!.statusCode == 200) {
        if (httpResult.data != null) {
          if (context.mounted) {
            await EglHelper.popMessage(context, MessageType.info, 'Article modified', widget.articleEditController.newArticle.titleArticle);
            Get.back();
          }
          await widget.articleController.getArticles();
          Get.back();
          return;
        } else {
          EglHelper.toastMessage(httpResult.error.toString());
          return;
        }
      } else if (httpResult.statusCode == 400) {
        if (context.mounted) {
          EglHelper.popMessage(context, MessageType.info, '${'mUnexpectedError'.tr}.', httpResult.error?.data);
          EglHelper.eglLogger('e', httpResult.error?.data);
        }
        return;
      } else if (httpResult.statusCode == 404) {
        if (context.mounted) {
          EglHelper.popMessage(context, MessageType.info, '${'mUnexpectedError'.tr}.', '${'mNoScriptAvailable'.tr}.');
          EglHelper.eglLogger('e', httpResult.error?.data['message']);
        }
        return;
      } else if (httpResult.statusCode == 503) {
        if (context.mounted) {
          EglHelper.popMessage(context, MessageType.info, 'Sin conexión.', '${'mNoScriptAvailable'.tr}.');
          EglHelper.eglLogger('e', httpResult.error?.data['message']);
        }
        return;
      } else if (httpResult.statusCode == 513) {
        if (context.mounted) {
          EglHelper.popMessage(context, MessageType.info, httpResult.data!.message, '${'mNoScriptAvailable'.tr}.');
          EglHelper.eglLogger('e', httpResult.error?.data['message']);
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

    return Scaffold(
        appBar: EglAppBar(
            //   elevation: 5,
            title: "tArticle".tr,
            //   titleWidget: Text("tArticles".tr),
            //   leadingWidget: const Icon(Icons.menu),
            //   hasDrawer: false,
            toolbarHeight: 80,
            showBackArrow: false,
            leadingIcon: Icons.arrow_back,
            leadingOnPressed: () => leadingOnPressed(),
            leadingWidget: null,
            bottom: TabBar(
              controller: _tabs.controller,
              tabs: _tabs.articleTabs,
            ),
            actions: [
              Obx(() {
                return
                    // Save article
                    EglCircleIconButton(
                  color: EglColorsApp.iconColor,
                  backgroundColor: EglColorsApp.transparent,
                  icon: Icons.save, // Cambiar a tu icono correspondiente
                  size: 30,
                  enabled: widget.articleEditController.canSave,
                  onPressed: () async {
                    if (widget.articleEditController.newArticle == widget.articleEditController.oldArticle) {
                      await EglHelper.showPopMessage(context, 'No ha cambiado nada', '', withImage: false, onPressed: () {
                        Get.back();
                      });
                      return;
                    }
                    if (widget.articleEditController.isNew) {
                      createArticle();
                    } else {
                      modifyArticle();
                    }
                  },
                );
                // : 1.pw;
              }),
              5.pw,
              Obx(() {
                // Browse article
                return EglCircleIconButton(
                  color: Colors.indigo.shade900,
                  backgroundColor: EglColorsApp.transparent,
                  icon: Icons.monitor, // Cambiar a tu icono correspondiente
                  size: 30,
                  enabled: widget.articleEditController.canSave,
                  onPressed: () {
                    IArticleUserArguments args = IArticleUserArguments(
                      ArticleUser.fromArticle(
                        article: widget.articleEditController.newArticle,
                        numOrder: 0,
                        idUser: widget.session.userConnected.idUser,
                        idAsociationUser: widget.session.userConnected.idAsociationUser,
                        emailUser: widget.session.userConnected.emailUser,
                        profileUser: widget.session.userConnected.profileUser,
                        nameUser: widget.session.userConnected.nameUser,
                        lastNameUser: widget.session.userConnected.lastNameUser,
                        avatarUser: widget.session.userConnected.avatarUser,
                        longNameAsociation: widget.session.userConnected.longNameAsoc,
                        shortNameAsociation: widget.session.userConnected.shortNameAsoc,
                      ),
                    );
                    Get.to(() => ArticlePage(articleArguments: args));
                  },
                );
                // : 1.pw;
              }),
              5.pw,
            ]),
        body: TabBarView(
          controller: _tabs.controller,
          children: const [
            ArticleEditionPage(),
            ArticleDataPage(),
          ],
        ));
  }
}

class ArticleDataTabs extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? controller;

  final List<Tab> articleTabs = <Tab>[
    const Tab(text: "Article editor"),
    const Tab(text: "Article data"),
  ];

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
