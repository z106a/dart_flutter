import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/imageModel.dart';
import 'widgets/imageList.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];
  
  void fetchImage() {
    counter++;
    get('https://jsonplaceholder.typicode.com/photos/$counter')
    .then((response) => ImageModel.fromJson(json.decode(response.body)))
    .then((imageModel) => setState(() {images.add(imageModel);}))
    .catchError((e) => debugPrint(e));
  }

  Widget build(context ) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: Text('Lets see some images'),
        ),
      ),
    );
  }
}