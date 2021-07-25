import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart' as m;

class ImageComponent extends StatefulWidget {

  final m.Model model;
  final m.Image image;

  const ImageComponent({Key? key, required this.image, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageComponentState(model, image);
  }
}

class ImageComponentState extends State {

  final m.Model _model;
  final m.Image image;

  ImageComponentState(this._model, this.image);

  @override
  void initState() {
    super.initState();
    _model.getImageFile(image)
    .then((value) {
      if (this.mounted)
        setState(() {
          image.localFile = value;
        });
      else print("not mounted");
    });
  }

  @override
  Widget build(BuildContext context) {
    final ratio = image.width.toDouble() / image.height.toDouble();
    final maxWidth = min(MediaQuery.of(context).size.width, image.width.toDouble());
    final maxHeight = maxWidth / ratio;
    final view = image.localFile == null ? CircularProgressIndicator() :
      Image.file(image.localFile!);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(width: maxWidth, height: maxHeight, child: Center(child: view)),
          Text(image.imageTitle),
        ],
      ),
    );
  }
}