// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:asocapp/app/utils/utils.dart';

import '../../resources/resources.dart';

// class EglArticleListTileController extends GetxController {
//   final SessionService session = Get.put<SessionService>(SessionService());
//   final EglTranslatorAiService _translator = EglTranslatorAiService();

//   final _titleController = <String>[].obs;
//   List<String> get titleController => _titleController;
//   set titleController(value) => _titleController.value = value;
//   final _subtitleController = <String>[].obs;
//   List<String> get subtitleController => _subtitleController;
//   set subtitleController(value) => _subtitleController.value = value;

//   final _loading = true.obs;
//   bool get loading => _loading.value;
//   set loading(value) => _loading.value = value;

//   String languageTo = '';

//   @override
//   void onInit() {
//     super.onInit();
//     languageTo = session.userConnected.languageUser;
//   }

//   void translate(int index, String title, String subtitle) {
//     _titleController[index] = title;
//     _subtitleController[index] = subtitle;

//     var text = '';

//     text = title;

//     _translator.translate(text, languageTo).then((value) {
//       if (value.trim() != '') {
//         _titleController[index] = value.trim();
//       }
//       text = subtitle;
//       return _translator.translate(text, languageTo);
//     }).then((value) {
//       if (value.trim() != '') _subtitleController[index] = value.trim();
//       _titleController.refresh();
//       _subtitleController.refresh();

//       loading = false;
//     }).catchError((error, stackTrace) {
//       Helper.eglLogger('e', 'translate: $text');
//       Helper.eglLogger('e', 'translate -> error :$error');
//       Helper.eglLogger('e', 'translate -> stackTrace :$stackTrace');
//       loading = false;
//     });
//   }
// }

class EglArticleListTile extends StatelessWidget {
  const EglArticleListTile({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.logo,
    required this.category,
    required this.subcategory,
    required this.leadingImage,
    required this.trailingImage,
    required this.onTap,
    required this.onTapCategory,
    required this.onTapSubcategory,
    required this.color,
    required this.gradient,
  }) : super(key: key);

// input data
  final int index;
  final String title;
  final String subtitle;
  final String logo;
  final String category;
  final String subcategory;
  final String leadingImage;
  final String? trailingImage;
  final VoidCallback onTap;
  final VoidCallback onTapCategory;
  final VoidCallback onTapSubcategory;
  final Color color;
  final Color gradient;

  // local variables

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              // borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              // gradient: LinearGradient(colors: [color, gradient], begin: Alignment.topCenter, end: Alignment.topRight),
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ))),
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      leadingImage,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title.toUpperCase(),
                              // maxLines: 2,
                              textAlign: TextAlign.center,
                              style: AppTheme.headline1.copyWith(
                                // color: Colors.black,
                                // fontWeight: FontWeight.w800,
                                // fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: title.length > 50 ? 12 : 16,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              subtitle.length > 100 ? '   ${subtitle.substring(0, 96)} ...' : '   $subtitle',
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              style: AppTheme.bodyText2.copyWith(
                                // color: Colors.black,
                                // fontWeight: FontWeight.w800,
                                // fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 14,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        children: [
                          InkWell(
                            onTap: onTapCategory,
                            child: Text(
                              category,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          const Text(
                            '/',
                            style: TextStyle(fontSize: 10),
                          ),
                          InkWell(
                            onTap: onTapSubcategory,
                            child: Text(
                              subcategory,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
