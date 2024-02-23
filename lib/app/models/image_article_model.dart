import 'dart:convert';

ImageArticle imageArticleRequestFromJson(String str) => ImageArticle.fromJson(json.decode(str));

String imageArticleRequestToJson(ImageArticle data) => json.encode(data.toJson());

class ImageArticle {
  ImageArticle({
    required this.src,
    required this.nameFile,
    required this.filePath,
    this.fileImage,
    required this.idImage,
    required this.isSelectedFile,
    required this.isDefault,
    required this.isChange,
  });

  String src;
  String nameFile;
  String filePath;
  dynamic fileImage;
  bool isSelectedFile;
  int idImage;
  bool isDefault;
  bool isChange;

  factory ImageArticle.fromJson(Map<String, dynamic> json) => ImageArticle(
        src: json["src"],
        nameFile: json["nameFile"],
        filePath: json["filePath"],
        fileImage: json["fileImage"] == '' ? null : json["fileImage"],
        idImage: json["idImage"],
        isSelectedFile: json["isSelectedFile"],
        isDefault: json["isDefault"],
        isChange: json["isChange"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "nameFile": nameFile,
        "filePath": filePath,
        "fileImage": fileImage ?? '',
        "idImage": idImage,
        "isSelectedFile": isSelectedFile,
        "isDefault": isDefault,
        "isChange": isChange,
      };

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena ImageArticle { ';
    cadena = '$cadena src $src';
    cadena = '$cadena nameFile $nameFile';
    cadena = '$cadena filePath $filePath';
    cadena = '$cadena fileImage ${fileImage ?? ''}';
    cadena = '$cadena idImage ${idImage.toString()}';
    cadena = '$cadena isSelectedFile $isSelectedFile';
    cadena = '$cadena isDefault $isDefault';
    cadena = '$cadena isChange $isChange';

    return cadena;
  }

  factory ImageArticle.clear() {
    return ImageArticle(
      src: '',
      nameFile: '',
      filePath: '',
      fileImage: null,
      idImage: 0,
      isSelectedFile: false,
      isDefault: false,
      isChange: false,
    );
  }

  ImageArticle copyWith({
    String? src,
    String? nameFile,
    String? filePath,
    dynamic fileImage,
    int? idImage,
    bool? isSelectedFile,
    bool? isDefault,
    bool? isChange,
  }) {
    return ImageArticle(
      src: src ?? this.src,
      nameFile: nameFile ?? this.nameFile,
      filePath: filePath ?? this.filePath,
      fileImage: fileImage == '' ? null : this.fileImage,
      idImage: idImage ?? this.idImage,
      isSelectedFile: isSelectedFile ?? this.isSelectedFile,
      isDefault: isDefault ?? this.isDefault,
      isChange: isChange ?? this.isChange,
    );
  }

  void modify({
    String? src,
    String? nameFile,
    String? filePath,
    dynamic fileImage,
    int? idImage,
    bool? isSelectedFile,
    bool? isDefault,
    bool? isChange,
  }) {
    this.src = src ?? this.src;
    this.nameFile = nameFile ?? this.nameFile;
    this.filePath = filePath ?? this.filePath;
    this.fileImage = fileImage ?? this.fileImage;
    this.idImage = idImage ?? this.idImage;
    this.isSelectedFile = isSelectedFile ?? this.isSelectedFile;
    this.isDefault = isDefault ?? this.isDefault;
    this.isChange = isChange ?? this.isChange;
  }
}
