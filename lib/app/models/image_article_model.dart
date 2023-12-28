import 'dart:convert';

ImageArticle articleRequestFromJson(String str) => ImageArticle.fromJson(json.decode(str));

String articleRequestToJson(ImageArticle data) => json.encode(data.toJson());

class ImageArticle {
  ImageArticle({
    required this.src,
    required this.nameFile,
    required this.filePath,
    this.fileImage,
    required this.isSelectedFile,
    required this.isDefault,
    required this.isChange,
  });

  String src;
  String nameFile;
  String filePath;
  dynamic fileImage;
  bool isSelectedFile;
  bool isDefault;
  bool isChange;

  factory ImageArticle.fromJson(Map<String, dynamic> json) => ImageArticle(
        src: json["src"],
        nameFile: json["nameFile"],
        filePath: json["filePath"],
        fileImage: json["fileImage"] == '' ? null : json["fileImage"],
        isSelectedFile: json["isSelectedFile"],
        isDefault: json["isDefault"],
        isChange: json["isChange"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "nameFile": nameFile,
        "filePath": filePath,
        "fileImage": fileImage ?? '',
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
    bool? isSelectedFile,
    bool? isDefault,
    bool? isChange,
  }) {
    return ImageArticle(
      src: src ?? this.src,
      nameFile: nameFile ?? this.nameFile,
      filePath: filePath ?? this.filePath,
      fileImage: fileImage == '' ? null : this.fileImage,
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
    bool? isSelectedFile,
    bool? isDefault,
    bool? isChange,
  }) {
    this.src = src ?? this.src;
    this.nameFile = nameFile ?? this.nameFile;
    this.filePath = filePath ?? this.filePath;
    this.fileImage = fileImage == '' ? null : this.fileImage;
    this.isSelectedFile = isSelectedFile ?? this.isSelectedFile;
    this.isDefault = isDefault ?? this.isDefault;
    this.isChange = isChange ?? this.isChange;
  }
}
