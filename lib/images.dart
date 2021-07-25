import 'package:flutter/material.dart';

import 'image.dart';
import 'model.dart' as m;

class ImagesComponentState extends State {

  final m.Model _model;

  bool isLoading = true;

  String loadingMessage = "We're setting up things...";

  List<m.Image> images = [];

  ImagesComponentState(this._model);

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingMessage = "We're loading images for you...";
    });
    _model.fetchImages()
    .then((value) => setState((){
      images = value;
      isLoading = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Loading, please wait...", style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Text(loadingMessage)
          ],
        ),
      );
    }
    return ListView.separated(itemBuilder: (BuildContext ctx, item) {
      return ImageComponent(model: _model, image: images[item]);
    }, separatorBuilder: (BuildContext ctx, index) {
      return Divider(height: 1, thickness: 1, color: Colors.black);
    }, itemCount: images.length);
  }
}

class ImagesComponent extends StatefulWidget {

  final m.Model model;

  const ImagesComponent({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImagesComponentState(model);
  }
}
