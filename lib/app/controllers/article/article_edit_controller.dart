import 'dart:async';
import 'dart:io';

import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/repositorys/repositorys.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ArticleEditController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final ArticlesRepository articlesRepository = Get.put(ArticlesRepository());

  final formKeyData = GlobalKey<FormState>();
  final formKeyEdition = GlobalKey<FormState>();

  final _oldArticle = Rx<Article>(Article.clear());
  Article get oldArticle => _oldArticle.value;
  set oldArticle(Article value) => _oldArticle.value = value;

  final _newArticle = Rx<Article>(Article.clear());
  Article get newArticle => _newArticle.value;
  set newArticle(Article value) => _newArticle.value = value;

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  Rx<DateTime> selectedDatePublication = DateTime.now().obs;
  Rx<DateTime> firstDatePublication = DateTime.now().obs;
  Rx<DateTime> lastDatePublication = DateTime(3000).obs;
  Rx<DateTime> selectedDateEffective = DateTime.now().obs;
  Rx<DateTime> firstDateEffective = DateTime.now().obs;
  Rx<DateTime> lastDateEffective = DateTime(3000).obs;
  Rx<DateTime> selectedDateExpiration = DateTime(4000).obs;
  Rx<DateTime> firstDateExpiration = DateTime.now().obs;
  Rx<DateTime> lastDateExpiration = DateTime(4001).obs;

  final _titleArticleFocusNode = FocusNode().obs;
  FocusNode get titleArticleFocusNode => _titleArticleFocusNode.value;

  final _abstractArticleFocusNode = FocusNode().obs;
  FocusNode get abstractArticleFocusNode => _abstractArticleFocusNode.value;

  final _categoryFocusNode = FocusNode().obs;
  FocusNode get categoryFocusNode => _categoryFocusNode.value;

  final _subcategoryFocusNode = FocusNode().obs;
  FocusNode get subcategoryFocusNode => _subcategoryFocusNode.value;

  final _stateFocusNode = FocusNode().obs;
  FocusNode get stateFocusNode => _stateFocusNode.value;

  List<dynamic> listArticleCategory = ArticleCategory.getListArticleCategory();
  List<dynamic> listArticleSubcategory = ArticleSubcategory.getListArticleSubcategory();
  List<dynamic> listArticleState = ArticleState.getListArticleState();

  final _listSubcategory = Rx<List<dynamic>>([]);
  List<dynamic> get listSubcategory => _listSubcategory.value;
  void actualizelistSubcategory(String value) {
    _listSubcategory.value = [];

    final List<dynamic> list = listArticleSubcategory
        .where((element) => element['category'].toString() == value)
        .map((e) => {'value': e['value'], 'name': e['name']})
        .toList();

    _listSubcategory.value = list;
  }

  final _imageCoverChanged = false.obs;
  bool get imageCoverChanged => _imageCoverChanged.value;
  set imageCoverChanged(bool value) => _imageCoverChanged.value = value;

  // Crop code
  final cropImagePath = ''.obs;
  final cropImageSize = ''.obs;

  // Image code
  final selectedImagePath = ''.obs;
  final selectedImageSize = ''.obs;

  // Compress code
  final compressedImagePath = ''.obs;
  final compressedImageSize = ''.obs;

  final _imageCover = Rx<XFile?>(XFile(''));
  XFile? get imageCover => _imageCover.value;
  set imageCover(XFile? value) => _imageCover.value = value;

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  bool checkIsFormValid() {
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path}');
    // Helper.eglLogger('i','checkIsFormValid: ${_imageCover.value!.path != ''}');
    final bool valid = (formKeyEdition.currentState?.validate() ?? false) && (formKeyData.currentState?.validate() ?? false);
    return _isFormValid.value = valid;
  }

  final _appLogo = ''.obs;
  String get appLogo => _appLogo.value;

  final _iconUserDefaultProfile = ''.obs;
  String get iconUserDefaultProfile => _iconUserDefaultProfile.value;
  set iconUserDefaultProfile(String value) => _iconUserDefaultProfile.value = value;

  @override
  Future<void> onInit() async {
    // Simulating obtaining the user name from some local storage

    _appLogo.value = await EglImagesPath.appLogo();
    _iconUserDefaultProfile.value = _appLogo.value;
    // // Escucha cambios en selectedDatePublication
    // ever(selectedDatePublication, (DateTime date) {
    // });

    super.onInit();
  }

  @override
  void onClose() {
    _titleArticleFocusNode.value.dispose();
    _abstractArticleFocusNode.value.dispose();
    _categoryFocusNode.value.dispose();
    _subcategoryFocusNode.value.dispose();
    _stateFocusNode.value.dispose();
    super.onClose();
  }

  final Rx<Image> imagePropertie = Rx<Image>(Image.asset(EglImagesPath.iconUserDefaultProfile));

//   Widget get imageWidget => imageWidget.value;
  Future<void> getImageWidget(XFile? imagePick) async {
    _imageCover.value = imagePick;
    // const double widthOval = 200.0;
    // const double heightOval = 200.0;

    if (imagePick == null) {
      // ignore: curly_braces_in_flow_control_structures
      if (_newArticle.value.coverImageArticle.src == '') {
        imagePropertie.value = Image.asset(appLogo);
      } else {
        imagePropertie.value = Image.network(_newArticle.value.coverImageArticle.src);
      }
    } else if (imagePick.path.substring(0, 4) == 'http') {
      imagePropertie.value = Image.network(imagePick.path);
    } else {
      imagePropertie.value = Image.file(File(imagePick.path));
    }
  }

  Future<void> pickImage(String option) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: option == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      //   selectedImagePath = File(pickedFile.path);
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = "${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Crop
      final cropImageFile =
          await ImageCropper().cropImage(sourcePath: selectedImagePath.value, maxWidth: 512, maxHeight: 512, compressFormat: ImageCompressFormat.png);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value = "${(File(cropImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Compress
      final dir = Directory.systemTemp;
      final nameFile = 'tempimage${EglHelper.generateChain()}.png';
      final targetPath = '${dir.absolute.path}/$nameFile';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        cropImagePath.value,
        targetPath,
        quality: 90,
        format: CompressFormat.png,
      );
      compressedImagePath.value = compressedFile!.path;
      compressedImageSize.value = "${(File(compressedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // final String imageBase64 = base64Encode(imageFile.readAsBytesSync());
      await getImageWidget(compressedFile);
      _imageCoverChanged.value = true;
      _newArticle.value.coverImageArticle.modify(
        src: compressedImagePath.value,
        nameFile: nameFile,
        filePath: '',
        fileImage: compressedFile,
        isSelectedFile: true,
        isDefault: false,
        isChange: true,
      );
    }
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path}');
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path != ''}');
    checkIsFormValid();
  }
}
