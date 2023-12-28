import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/article/article_edit_controller.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleEditionPage extends StatefulWidget {
  const ArticleEditionPage({super.key});

  @override
  State<ArticleEditionPage> createState() => _ArticleEditionPageState();
}

class _ArticleEditionPageState extends State<ArticleEditionPage> {
  final articleEditController = Get.put<ArticleEditController>(ArticleEditController());
  final SessionService session = Get.put<SessionService>(SessionService());

  @override
  void initState() {
    super.initState();

    // EglImagesPath.appLogo().then((image) {
    //   if (articleEditController.oldArticle.idArticle == 0) {
    //     articleEditController.newArticle.coverImageArticle.modify(
    //       src: image,
    //       nameFile: EglImagesPath.nameIconUserDefaultProfile,
    //       isDefault: true,
    //     );

    //     articleEditController.imagePropertie.value = Image.asset(image);
    //   } else {
    //     articleEditController.newArticle = articleEditController.oldArticle.copyWith();
    //     articleEditController.imagePropertie.value = Image.network(articleEditController.newArticle.coverImageArticle.src);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('ArticleEditionPage'));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          20.ph,
          Form(
            key: articleEditController.formKeyEdition,
            autovalidateMode: AutovalidateMode.onUserInteraction, // Habilita la validación cuando el usuario interactúa con el formulario
            onChanged: () {},
            child: _formUI(context, articleEditController),
          ),
        ],
      ),
    );
  }

  Widget _formUI(BuildContext context, ArticleEditController articleEditController) {
    bool titleFocus = false;
    bool abstractFocus = false;

    // double widthMediaQuery = MediaQuery.of(context).size.width * .8;

    List<Map<String, dynamic>> optionsGetImage = [
      {'option': 'camera', 'texto': 'Camara', 'icon': Icons.camera_alt_outlined},
      {'option': 'gallery', 'texto': 'Galería', 'icon': Icons.browse_gallery}
    ];

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.ph,
          // Title
          EglInputMultiLineField(
            focusNode: articleEditController.titleArticleFocusNode,
            nextFocusNode: articleEditController.abstractArticleFocusNode,
            currentValue: articleEditController.newArticle.titleArticle,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            iconLabel: Icons.person_pin,
            // ronudIconBorder: true,
            labelText: 'lTitleArticle'.tr,
            hintText: 'hTitleArticle'.tr,
            maxLines: null,
            maxLength: 100,
            // icon: Icons.person_pin,
            onChanged: (value) {
              articleEditController.newArticle.titleArticle = value;
              titleFocus = articleEditController.titleArticleFocusNode.hasFocus;
              //   titleKey.currentState?.validate();
            },
            onValidator: (value) {
              if (titleFocus) {
                if (value!.isEmpty) return 'Introduzca el título del artículo';
                if (value.length < 4) return 'El título ha de tener 4 carácteres como mínimo ';
                if (value.length > 100) return 'El título ha de tener 100 carácteres como máximo ';
              }
              return null;
            },
          ),
          20.ph,
          // Abstract
          EglInputMultiLineField(
            focusNode: articleEditController.abstractArticleFocusNode,
            nextFocusNode: articleEditController.abstractArticleFocusNode,
            currentValue: articleEditController.newArticle.abstractArticle,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            iconLabel: Icons.person_pin,
            // ronudIconBorder: true,
            labelText: 'lAbstractArticle'.tr,
            hintText: 'hAbstractArticle'.tr,
            maxLines: null,
            maxLength: 200,
            // icon: Icons.person_pin,
            onChanged: (value) {
              articleEditController.newArticle.abstractArticle = value;
              abstractFocus = articleEditController.abstractArticleFocusNode.hasFocus;
              //   abstractKey.currentState?.validate();
            },
            onValidator: (value) {
              if (abstractFocus) {
                if (value!.isEmpty) return 'Introduzca el abstract del artículo';
                if (value.length < 4) return 'El abstract ha de tener 4 carácteres como mínimo ';
                if (value.length > 200) return 'El abstract ha de tener 200 carácteres como máximo ';
              }
              return null;
            },
          ),
          (articleEditController.imageCoverChanged || !articleEditController.newArticle.coverImageArticle.isDefault) ? 30.ph : 20.ph,
          // Cover widget
          EglImageWidget(),
          20.ph,
          // SizedBox(
          //   width: Get.width * .8,
          //   child: FittedBox(
          //     child: articleEditController.imagePropertie.value,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class EglImageWidget extends StatelessWidget {
  const EglImageWidget({
    super.key,
    this.controller,
  });

  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> optionsGetImage = [
      {'option': 'camera', 'texto': 'Camara', 'icon': Icons.camera_alt_outlined},
      {'option': 'gallery', 'texto': 'Galería', 'icon': Icons.browse_gallery}
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover
        GestureDetector(
          onTap: () async {
            EglHelper.showMultChoiceDialog(
              optionsGetImage,
              'tQuestions'.tr,
              context: context,
              onChanged: (value) async {
                Get.back();
                await controller.pickImage(value);
              },
            );
          },
          child: controller.newArticle.coverImageArticle.src != ''
              ? FittedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0), // ajusta el radio según sea necesario
                      border: Border.all(
                        color: EglColorsApp.borderTileArticleColor, // color del borde
                        width: 2.0, // ancho del borde
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: controller.imagePropertie.value,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), // ajusta el radio según sea necesario
                    border: Border.all(
                      color: Colors.transparent, // color del borde
                      width: 2.0, // ancho del borde
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    // Image.network(articleEditController.newArticle.coverImageArticle.src)
                    child: controller.appLogo == ''
                        ? null
                        : Image.network(
                            controller.appLogo,
                            width: MediaQuery.of(context).size.width * .88,
                            // height: 300,
                          ),
                  ),
                ),
        ),
        // Button restore default cover
        //   if (articleEditController.imageCoverChanged)
        Positioned(
          top: -18.0, // Ajusta según sea necesario
          right: 10.0, // Ajusta según sea necesario
          child: EglCircleIconButton(
            backgroundColor: EglColorsApp.backgroundIconColor,
            icon: Icons.disabled_by_default_outlined, // Cambiar a tu icono correspondiente
            onPressed: () {
              // Lógica para recuperar la imagen por defecto
              controller.newArticle.coverImageArticle.modify(
                src: controller.iconUserDefaultProfile,
                nameFile: 'icons_user_profile_circle',
                isDefault: true,
              );
              controller.imageCover = null;
              controller.imagePropertie.value = Image.network(articleEditController.newArticle.coverImageArticle.src);
            },
          ),
        ),
        // Button restore initial cover
        //   if (articleEditController.imageCoverChanged)
        Positioned(
          top: -18.0, // Ajusta según sea necesario
          right: 70.0, // Ajusta según sea necesario
          child: EglCircleIconButton(
            backgroundColor: EglColorsApp.backgroundIconColor,
            icon: Icons.restore, // Cambiar a tu icono correspondiente
            onPressed: () {
              // Lógica para restaurar la imagen inicial
              articleEditController.newArticle.coverImageArticle = articleEditController.oldArticle.coverImageArticle.copyWith();
              articleEditController.imageCover = null;
              articleEditController.imagePropertie.value = Image.network(articleEditController.newArticle.coverImageArticle.src);
            },
          ),
        ),
      ],
    );
  }
}
