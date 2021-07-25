import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Image {
  final int imageId;
  final int authorId;
  final String imageType;
  final String imageHash;
  final String imageTitle;
  final int width;
  final int height;

  File? localFile;

  Image(this.imageId, this.authorId, this.imageType, this.imageHash, this.imageTitle, this.width, this.height);

  Image.fromJson(Map<String, dynamic> json)
    : imageId = json['imageId'],
      authorId = json['imageAuthorId'],
      imageType = json['imageType'],
      imageHash = json['imageHash'],
      imageTitle = json['imageTitle'],
      width = json['width'],
      height = json['height'];

  Map<String, dynamic> toJson() {
    return {
      "imageId": imageId,
      "imageAuthorId": authorId,
      "imageType": imageType,
      "imageHash": imageHash,
      "imageTitle": imageTitle,
      'width': width,
      'height': height
    };
  }

}

class Model {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<List<Image>> fetchImages() async {
    final resp = await http.get(Uri.parse("http://192.168.100.6:8082/image/all"));
    final List<dynamic> json = jsonDecode(resp.body);
    return json.map((e) => Image.fromJson(e)).toList();
  }

  Future<File?> getImageFile(Image image) async {
    final dirPath = await _localPath;
    final file = File("$dirPath/${image.imageHash}.bin");
    if (await file.exists())
      return file;
    return fetchContent(file, image);
  }

  Future<File> fetchContent(File file, Image image) async {
    final resp = await http.get(Uri.parse("http://192.168.100.6:8082/image/content/${image.imageId}"));
    return store(file, resp.bodyBytes);
  }

  Future<File> store(File file, Uint8List data) async {
    return file.writeAsBytes(data);
  }
}