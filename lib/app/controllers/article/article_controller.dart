import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/repositorys/articles_repository.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ArticleController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());
  final EglTranslatorAiService _translator = EglTranslatorAiService();

  final _articles = <ArticleUser>[].obs; // Lista de artículos
  List<ArticleUser> get articles => _articles;
  set articles(value) => _articles.value = value;
  List<ArticleUser> get articlesList => _articles.toList();
  List<dynamic> get articlesAbstractList => _articles
      .map((item) => {
            'id': item.idArticle,
            'name': item.abstractArticle,
          })
      .toList();
  List<ArticleUser> get articlesPublicatedList => _articles
      .where((ArticleUser article) =>
          article.stateArticle == 'publicado' &&
          (article.idAsociationArticle == session.userConnected.idAsociationUser || article.idAsociationArticle == 999999999))
      .toList();
  List<ArticleUser> get allArticlesList => _articles
      .where((ArticleUser article) =>
          (article.idAsociationArticle == session.userConnected.idAsociationUser || article.idAsociationArticle == 999999999))
      .toList();

  final _article = Rx<ArticleUser>(ArticleUser.clear()); // Artículo
  ArticleUser get article => _article.value;

  final _selectedArticle = Rx<ArticleUser>(ArticleUser.clear());
  ArticleUser get selectedArticle => _selectedArticle.value;

  final Logger logger = Logger();

  final _loadingArticle = false.obs;
  bool get loadingArticle => _loadingArticle.value;
  set loadingArticle(value) => _loadingArticle.value = value;

  final articleList = <ArticleUser>[].obs;

  final _titleArticleTr = <String>[].obs;
  List<String> get titleArticleTr => _titleArticleTr;
  set titleArticleTr(value) => _titleArticleTr.value = value;

  get languageUser => session.userConnected.languageUser;

  @override
  void onInit() {
    super.onInit();
    getArticles();
  }

  void isLogin() {
    if (session.isLogin) {
      // Utils.eglLogger('e', 'ArticlesListView: init State isLogin');
      if (session.userConnected.recoverPasswordUser != 0) {
        Get.offAll(() => const ChangePage());
      }
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  Color getColorState(ArticleUser article) {
    if (session.userConnected.profileUser == 'admin' && session.checkEdit && session.userConnected.idAsociationUser == article.idAsociationArticle) {
      switch (article.stateArticle) {
        case 'redacción':
          return EglColorsApp.workingColor;
        case 'publicado':
          return EglColorsApp.backgroundTileColor;
        case 'revisión':
          return EglColorsApp.warningColor;
        case 'expirado':
          return EglColorsApp.infoColor;
        case 'anulado':
          return EglColorsApp.alertColor;

        default:
      }
    }
    return EglColorsApp.backgroundTileColor;
  }

  Future<void> getArticles() async {
    final ArticleListResponse articlesListResponse = await articlesRepository.getArticles();

    _articles.value = [];
    // print('Response body: ${result}');
    if (articlesListResponse.status == 200) {
      articlesListResponse.result.map((article) => _articles.add(article)).toList();
      if (articlesListResponse.message == 'expired') {
        session.isExpired = true;
        session.setListUserMessages('Session expired. Reloggin for edit articles');
        session.checkEdit = false;
      }
    }
    // return _articles;
  }

// Devuelve una lista de Artículos sin traducir
  Future<List<ArticleUser>> getAllArticlesList() async {
    List<ArticleUser> list = [];

    for (final article in allArticlesList) {
      if (session.userConnected.idAsociationUser == article.idAsociationArticle ||
          (article.idAsociationArticle == 999999999 && article.stateArticle == 'publicado')) {
        list.add(article);
      }
    }
    return list;
  }

// Devuelve una lista de Artículos con stateArticle 'publicado' con título y abstract traducidos
  Future<List<ArticleUser>> getArticlesPublicatedList() async {
    List<ArticleUser> translatedArticles = [];

    await Future.wait(articlesPublicatedList.map((article) async {
      String tra1 = await _translator.translate(article.titleArticle, languageUser);
      String tra2 = await _translator.translate(article.abstractArticle, languageUser);

      translatedArticles.add(article.copyWith(
        titleArticle: tra1.trim() == '' ? article.titleArticle : tra1.trim(),
        abstractArticle: tra2.trim() == '' ? article.abstractArticle : tra2.trim(),
      ));
    }));

    return translatedArticles;
  }

// Devuelve un artículo completamente traducido
  Future<ArticleUser> getArticleUserPublicated(ArticleUser article) async {
    ArticleUser transArticle = article.copyWith();

    await Future.wait(transArticle.itemsArticle.map((item) async {
      String text = item.textItemArticle.trim();
      EglHelper.eglLogger('i', 'text.length: ${text.length}');
      EglHelper.eglLogger('i', 'text: $text');

      if (text.isNotEmpty) {
        try {
          String tra1 = await _translator.translate(text, languageUser);
          if (tra1.trim().isNotEmpty) {
            EglHelper.eglLogger('i', 'tra1: $tra1');
            item.textItemArticle = tra1.trim();
          }
        } catch (e) {
          EglHelper.eglLogger('i', 'e: $e');
        }
      }
    }));

    return Future.value(transArticle);
  }

// No se usa
  Future<ArticleUser> getArticle(ArticleUser article) async {
    List<ItemArticle> list = List.filled(article.itemsArticle.length, ItemArticle.clear());

    for (var i = 0; i < article.itemsArticle.length; i++) {
      String text = article.itemsArticle[i].textItemArticle.trim();
      EglHelper.eglLogger('i', 'text[$i].length: ${text.length}');
      EglHelper.eglLogger('i', 'text[$i]: $text');
      //
      //   i == 0
      //       ? text =
      //           '<h2 style="margin-left:0px;"><a href="https://cadascu.wordpress.com/2011/11/18/cmo-recuperar-un-samsung-galaxy-s-que-no-arranca-incluso-bloqueado-de-fbrica/"><strong>Cómo recuperar un Samsung Galaxy S que no arranca, incluso bloqueado de fábrica</strong></a></h2><p style="margin-left:0px;"><span style="background-color:transparent;">Publicado el</span> <a href="https://cadascu.wordpress.com/2011/11/18/cmo-recuperar-un-samsung-galaxy-s-que-no-arranca-incluso-bloqueado-de-fbrica/"><span style="background-color:transparent;">18 noviembre, 2011</span></a><span style="background-color:transparent;">por</span> <a href="https://cadascu.wordpress.com/author/rqvalencia/"><span style="background-color:transparent;">Rafael Quintana</span></a></p><p style="margin-left:0px;">14 Votes</p><h4 style="margin-left:0px;">Ha pasado bastantes días desde el último post. Han sido semanas de muchas pruebas y disfrute del teléfono, pero desafortunadamente también de un gran susto. Y es que hace una semana, por accidente y una fatídica coincidencia, mi Samsung Galaxy S quedó convertido en un ladrillo (<i>bricked</i>, como dicen los angloparlantes).</h4>'
      //       : 0;
      if (text != '') {
        String tra1 = await _translator.translate(text, languageUser);
        if (tra1.trim() != '') {
          EglHelper.eglLogger('i', 'tra1[$i]: $tra1');
          text = tra1.trim();
        }
        list[i] = article.itemsArticle[i].copyWith(textItemArticle: text);
      }
    }
    ArticleUser transArticle = article.copyWith(itemsArticle: list);
    return transArticle;
  }

  Future<ArticleUser> getSingleArticle(int idarticle) async {
    final ArticleResponse articlesResponse = await articlesRepository.getSingleArticle(idarticle);

    // print('Response body: ${result}');
    if (articlesResponse.status == 200) {
      _article.value = articlesResponse.result;
    }
    return _article.value;
  }
}
