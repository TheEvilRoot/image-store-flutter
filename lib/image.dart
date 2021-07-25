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
    _model.fetchContent(image)
    .then((value) => setState(() {
      image.content = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    final view = image.content == null ?
      Text("Loading...") :
      Image.memory(image.content!);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          view,
          Text(image.imageTitle),
        ],
      ),
    );
  }
}