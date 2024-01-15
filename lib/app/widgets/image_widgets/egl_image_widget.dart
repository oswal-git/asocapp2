import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EglImageWidget extends StatefulWidget {
  const EglImageWidget({
    super.key,
    required this.image,
    required this.defaultImage,
    this.onChange,
    this.onPressedDefault,
    this.onPressedRestore,
    this.iconsSize,
    this.isEditable = false,
    this.canDefault = true,
  });

  final ImageArticle image;
  final String defaultImage;
  final double? iconsSize;
  final bool isEditable;
  final bool canDefault;
  final ValueChanged<ImageArticle>? onChange;
  final ValueChanged<ImageArticle>? onPressedDefault;
  final ValueChanged<ImageArticle>? onPressedRestore;

  @override
  State<EglImageWidget> createState() => _EglImageWidgetState();
}

class _EglImageWidgetState extends State<EglImageWidget> {
  Image imagePropertie = Image.asset('assets/images/icons_user_profile_circle.png');

  ImageArticle oldImageArticle = ImageArticle.clear();
  ImageArticle newImageArticle = ImageArticle.clear();

  bool imageChanged = false;

  // Crop code
  String cropImagePath = '';
  String cropImageSize = '';

  // Image code
  String selectedImagePath = '';
  String selectedImageSize = '';

  // Compress code
  String compressedImagePath = '';
  String compressedImageSize = '';

  XFile? imagePicked = XFile('');

  double defaultSize = 40;
  double widthBox = 0;
  double iconsSize = 20.0;
  double top = -16;
  double right = 8;
  double right2 = 50;

  @override
  void initState() {
    super.initState();

    oldImageArticle = widget.image.copyWith();

    newImageArticle = widget.image.copyWith();

    // getImageWidget(null, maxwidth: MediaQuery.of(context).size.width / 2);
  }

  Future<void> getImageWidget(XFile? imagePick, {double maxwidth = 0}) async {
    imagePicked = imagePick;
    // const double widthOval = 200.0;
    // const double heightOval = 200.0;

    if (imagePick == null) {
      // ignore: curly_braces_in_flow_control_structures
      if (newImageArticle.src.substring(0, 4) == 'http') {
        if (newImageArticle.isDefault) {
          imagePropertie = Image.network(newImageArticle.src, width: defaultSize);
          return;
        }
        imagePropertie = Image.network(newImageArticle.src);
        return;
      }

      if (newImageArticle.isDefault) {
        imagePropertie = Image.asset(newImageArticle.src, width: defaultSize);
        return;
      }
      imagePropertie = Image.file(File(newImageArticle.src));
      return;
    }

    if (imagePick.path.substring(0, 4) == 'http') {
      imagePropertie = Image.network(imagePick.path);
      return;
    }
    imagePropertie = Image.file(File(imagePick.path));
  }

  Future<void> pickImage(String option) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: option == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      //   selectedImagePath = File(pickedFile.path);
      selectedImagePath = pickedFile.path;
      selectedImageSize = "${(File(selectedImagePath).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Crop
      final cropImageFile =
          await ImageCropper().cropImage(sourcePath: selectedImagePath, maxWidth: 512, maxHeight: 512, compressFormat: ImageCompressFormat.png);
      cropImagePath = cropImageFile!.path;
      cropImageSize = "${(File(cropImagePath).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Compress
      final dir = Directory.systemTemp;
      final nameFile = 'tempimage${EglHelper.generateChain()}.png';
      final targetPath = '${dir.absolute.path}/$nameFile';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        cropImagePath,
        targetPath,
        quality: 90,
        format: CompressFormat.png,
      );
      compressedImagePath = compressedFile!.path;
      compressedImageSize = "${(File(compressedImagePath).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // final String imageBase64 = base64Encode(imageFile.readAsBytesSync());
      imageChanged = true;
      newImageArticle.modify(
        src: compressedImagePath,
        nameFile: nameFile,
        filePath: '',
        fileImage: compressedFile,
        isSelectedFile: true,
        isDefault: false,
        isChange: true,
      );
      await getImageWidget(compressedFile);
    }
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path}');
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path != ''}');
    // checkIsFormValid();
  }

  String getNameFilePath(String path, {String fileSeparator = '/', String extSeparator = '.'}) => path.substring(
      path.lastIndexOf(fileSeparator) == -1 ? 0 : path.lastIndexOf(fileSeparator) + 1,
      path.lastIndexOf(extSeparator) == -1 ? path.length : path.lastIndexOf(extSeparator));

  void getPosition(double width) {
    iconsSize = width / 10.0;
    iconsSize = widget.iconsSize ?? iconsSize;

    top = -3 * (iconsSize - 10) / 5 - 10;
    right = (iconsSize - 10) / 5 + 6;
    right2 = ((iconsSize - 10) * 2) + 30;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> optionsGetImage = [
      {'option': 'camera', 'texto': 'Camara', 'icon': Icons.camera_alt_outlined},
      {'option': 'gallery', 'texto': 'Galería', 'icon': Icons.browse_gallery}
    ];

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      // widthBox = constraints.maxWidth;
      // double height = constraints.maxHeight;

      if (widthBox == 0) {
        widthBox = constraints.maxWidth;
        getPosition(widthBox);
        getImageWidget(null, maxwidth: MediaQuery.of(context).size.width / 2);
      }

      return Column(
        children: [
          SizedBox(
            height: newImageArticle.isDefault ? 10 : 20,
          ),
          Align(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover
                GestureDetector(
                  onTap: () async {
                    if (widget.isEditable) {
                      EglHelper.showMultChoiceDialog(
                        optionsGetImage,
                        'tQuestions'.tr,
                        context: context,
                        onChanged: (value) async {
                          Get.back();
                          await pickImage(value);
                          setState(() {
                            widget.onChange!(newImageArticle);
                          });
                        },
                      );
                    }
                  },
                  child: !newImageArticle.isDefault
                      ? FittedBox(
                          child: Container(
                            // width: MediaQuery.of(context).size.width * .88,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0), // ajusta el radio según sea necesario
                              border: Border.all(
                                color: const Color(0xFFAAAAAA), // color del borde
                                width: 2.0, // ancho del borde
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: imagePropertie,
                            ),
                          ),
                        )
                      : Container(
                          width: 100,
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
                            child: widget.defaultImage == ''
                                ? null
                                : Image.network(
                                    widget.defaultImage,
                                    width: defaultSize,
                                    height: defaultSize + 30,
                                  ),
                          ),
                        ),
                ),
                // Button restore default cover
                if (widget.isEditable && widget.canDefault && !oldImageArticle.isDefault && !newImageArticle.isDefault)
                  Positioned(
                    top: top, // Ajusta según sea necesario
                    right: right, // Ajusta según sea necesario
                    child: EglCircleIconButton(
                        // key: UniqueKey(),
                        backgroundColor: const Color(0xFFAAAAAA),
                        icon: Icons.disabled_by_default_outlined, // X
                        size: iconsSize,
                        onPressed: () {
                          // Lógica para recuperar la imagen por defecto

                          newImageArticle.modify(
                            src: widget.defaultImage,
                            nameFile: getNameFilePath(widget.defaultImage),
                            isDefault: true,
                            isChange: widget.image.isDefault ? false : true,
                          );
                          imageChanged = widget.image.isDefault ? false : true;
                          imagePicked = null;
                          getImageWidget(null, maxwidth: MediaQuery.of(context).size.width / 2);
                          // imagePropertie = Image.asset(
                          //   newImageArticle.src,
                          //   width: MediaQuery.of(context).size.width / 2,
                          // );

                          widget.onPressedDefault!(newImageArticle);
                          getPosition(MediaQuery.of(context).size.width / 2);
                          setState(() {});
                        }),
                  ),
                // Button restore initial cover
                if (widget.isEditable && imageChanged)
                  Positioned(
                    top: newImageArticle.isDefault ? (top + 10) : top, // Ajusta según sea necesario, // Ajusta según sea necesario
                    right: (imageChanged && !oldImageArticle.isDefault && !newImageArticle.isDefault)
                        ? right2
                        : newImageArticle.isDefault
                            ? (right - 20)
                            : right, // Ajusta según sea necesario
                    child: EglCircleIconButton(
                      // key: UniqueKey(),
                      backgroundColor: const Color(0xFFAAAAAA),
                      icon: Icons.restore, // Relojito hacia atrás
                      size: iconsSize,
                      onPressed: () {
                        // Lógica para restaurar la imagen inicial
                        imageChanged = false;
                        newImageArticle = widget.image.copyWith();
                        imagePicked = null;
                        if (widget.image.isDefault) {
                          getImageWidget(null, maxwidth: MediaQuery.of(context).size.width / 2);
                        } else {
                          getImageWidget(null);
                        }
                        // widget.image.isDefault ? imagePropertie = Image.asset(newImageArticle.src) : imagePropertie = Image.network(newImageArticle.src);

                        widget.onPressedRestore!(newImageArticle);
                        getPosition(widthBox);
                        setState(() {});
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
