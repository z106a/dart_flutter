import 'package:flutter/material.dart';
import 'screens/newsList.dart';
import 'blocks/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}