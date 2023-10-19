import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/repositorys/articles_repository.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:translator/translator.dart';

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

  final loading = false.obs;
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
      Translation tra1 = await _translator.translate(articlePublicated.titleArticle, languageUser);
      if (tra1.text.trim() != '') {
        articlePublicated.titleArticle = tra1.text.trim();
      }

      Translation tra2 = await _translator.translate(articlePublicated.abstractArticle, languageUser);

      if (tra2.text.trim() != '') {
        articlePublicated.abstractArticle = tra2.text.trim();
      }
      list.add(articlePublicated);
      //   } else {
      //     list.add(articlePublicated);
      //   }
    }

    return list;
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
