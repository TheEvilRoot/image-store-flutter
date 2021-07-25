import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class Image {
  final int imageId;
  final int authorId;
  final String imageType;
  final String imageHash;
  final String imageTitle;

  Uint8List? content;

  Image(this.imageId, this.authorId, this.imageType, this.imageHash, this.imageTitle);

  Image.fromJson(Map<String, dynamic> json)
    : imageId = json['imageId'],
      authorId = json['imageAuthorId'],
      imageType = json['imageType'],
      imageHash = json['imageHash'],
      imageTitle = json['imageTitle'];

  Map<String, dynamic> toJson() {
    return {
      "imageId": imageId,
      "imageAuthorId": authorId,
      "imageType": imageType,
      "imageHash": imageHash,
      "imageTitle": imageTitle
    };
  }

}

class Model {

  Future<List<Image>> fetchImages() async {
    final resp = await http.get(Uri.parse("http://192.168.100.6:8082/image/all"));
    final List<dynamic> json = jsonDecode(resp.body);
    return json.map((e) => Image.fromJson(e)).toList();
  }

  Future<Uint8List> fetchContent(Image image) async {
    final resp = await http.get(Uri.parse("http://192.168.100.6:8082/image/content/${image.imageId}"));
    return resp.bodyBytes;
  }
}