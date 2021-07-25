import 'package:app/images.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class HomePage extends StatelessWidget {

  final Model model;

  const HomePage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
        backgroundColor: Colors.amberAccent,
      ),
      body: ImagesComponent(model: model)
    );
  }
}
