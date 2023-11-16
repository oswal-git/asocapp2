import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/repositorys/articles_repository.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ArticleController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());
  final EglTranslatorAiService _translator = EglTranslatorAiService();

  final _articles = <Article>[].obs; // Lista de artículos
  List<Article> get articles => _articles;
  set articles(value) => _articles.value = value;
  List<Article> get articlesList => _articles.toList();
  List<dynamic> get articlesAbstractList => _articles
      .map((item) => {
            'id': item.idArticle,
            'name': item.abstractArticle,
          })
      .toList();
  List<Article> get articlesPublicatedList => _articles
      .where((Article article) =>
          article.stateArticle == 'publicado' &&
          (article.idAsociationArticle == session.userConnected.idAsociationUser || article.idAsociationArticle == 999999999))
      .toList();

  final _article = Rx<Article>(Article.clear()); // Artículo
  Article get article => _article.value;

  final _selectedArticle = Rx<Article>(Article.clear());
  Article get selectedArticle => _selectedArticle.value;

  final Logger logger = Logger();

  final _loadingArticle = false.obs;
  bool get loadingArticle => _loadingArticle.value;
  set loadingArticle(value) => _loadingArticle.value = value;

  final articleList = <Article>[].obs;

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

  Future<void> getArticles() async {
    final ArticleListResponse articlesListResponse = await articlesRepository.getArticles();

    _articles.value = [];
    // print('Response body: ${result}');
    if (articlesListResponse.status == 200) {
      articlesListResponse.result.map((article) => _articles.add(article)).toList();
    }
    // return _articles;
  }

  Future<List<Article>> getArticlesPublicatedList() async {
    List<Article> list = [];

    for (final articlePublicated in articlesPublicatedList) {
      //   if (languageUser != 'es') {
      String tra1 = await _translator.translate(articlePublicated.titleArticle, languageUser);
      if (tra1.trim() != '') {
        articlePublicated.titleArticle = tra1.trim();
      }

      String tra2 = await _translator.translate(articlePublicated.abstractArticle, languageUser);

      if (tra2.trim() != '') {
        articlePublicated.abstractArticle = tra2.trim();
      }
      list.add(articlePublicated);
      //   } else {
      //     list.add(articlePublicated);
      //   }
    }

    return list;
  }

  Future<Article> getArticlePublicated(Article article) async {
    List<ItemArticle> list = List.filled(article.itemsArticle.length, ItemArticle.clear());

    for (var i = 0; i < article.itemsArticle.length; i++) {
      String text = article.itemsArticle[i].textItemArticle.trim();
      Helper.eglLogger('i', 'text[$i].length: ${text.length}');
      Helper.eglLogger('i', 'text[$i]: $text');
      //
      //   i == 0
      //       ? text =
      //           '<h2 style="margin-left:0px;"><a href="https://cadascu.wordpress.com/2011/11/18/cmo-recuperar-un-samsung-galaxy-s-que-no-arranca-incluso-bloqueado-de-fbrica/"><strong>Cómo recuperar un Samsung Galaxy S que no arranca, incluso bloqueado de fábrica</strong></a></h2><p style="margin-left:0px;"><span style="background-color:transparent;">Publicado el</span> <a href="https://cadascu.wordpress.com/2011/11/18/cmo-recuperar-un-samsung-galaxy-s-que-no-arranca-incluso-bloqueado-de-fbrica/"><span style="background-color:transparent;">18 noviembre, 2011</span></a><span style="background-color:transparent;">por</span> <a href="https://cadascu.wordpress.com/author/rqvalencia/"><span style="background-color:transparent;">Rafael Quintana</span></a></p><p style="margin-left:0px;">14 Votes</p><h4 style="margin-left:0px;">Ha pasado bastantes días desde el último post. Han sido semanas de muchas pruebas y disfrute del teléfono, pero desafortunadamente también de un gran susto. Y es que hace una semana, por accidente y una fatídica coincidencia, mi Samsung Galaxy S quedó convertido en un ladrillo (<i>bricked</i>, como dicen los angloparlantes).</h4>'
      //       : 0;
      if (text != '') {
        String tra1 = await _translator.translate(text, languageUser);
        if (tra1.trim() != '') {
          Helper.eglLogger('i', 'tra1[$i]: $tra1');
          text = tra1.trim();
        }
        list[i] = article.itemsArticle[i].copyWith(textItemArticle: text);
      }
    }
    Article transArticle = article.copyWith(itemsArticle: list);
    return transArticle;
  }

  Future<Article> getSingleArticle(int idarticle) async {
    final ArticleResponse articlesResponse = await articlesRepository.getSingleArticle(idarticle);

    // print('Response body: ${result}');
    if (articlesResponse.status == 200) {
      _article.value = articlesResponse.result;
    }
    return _article.value;
  }
}
