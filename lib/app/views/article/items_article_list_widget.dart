import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/views/article/edit_item_article.dart';
import 'package:flutter/material.dart';

class ItemsArticleListWidget extends StatefulWidget {
  const ItemsArticleListWidget({
    super.key,
  });

  @override
  State<ItemsArticleListWidget> createState() => _ItemsArticleListWidgetState();
}

class _ItemsArticleListWidgetState extends State<ItemsArticleListWidget> {
  @override
  Widget build(BuildContext context) {
    // final articleEditController = Get.put<ArticleEditController>(ArticleEditController());

    return Expanded(
      child:
          // Obx(
          //   () =>
          // articleEditController.newArticleItems.isEmpty ?
          // Container()
          // : ListView.builder(
          //     key: UniqueKey(),
          //     itemCount: articleEditController.newArticleItems.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       ItemArticle item = articleEditController.newArticleItems[index];
          //       if (item.imageItemArticle.isDefault) {
          //         item.imageItemArticle.modify(
          //           src: EglImagesPath.appCoverDefault,
          //           nameFile: EglHelper.getNameFilePath(EglImagesPath.appCoverDefault),
          //           isDefault: true,
          //         );
          //       }
          //       return
          Container(
        padding: const EdgeInsets.only(bottom: 10.0, top: 40.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.only(bottom: 10.0, top: 40.0),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
            border: Border(
              top: BorderSide(
                color: EglColorsApp.borderTileArticleColor, // color del borde
                width: 2.0, // ancho del borde)
              ),
            ),
          ),
          child: EditItemArticle(itemArticle: ItemArticle.clear()),
        ),
        //         // Index del item
        //       );
        //     },
        //   ),
      ),
      // ),
    );
  }
}
