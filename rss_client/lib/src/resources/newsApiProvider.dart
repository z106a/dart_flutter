import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import '../models/itemModel.dart';
import 'repository.dart';

final _BASE_URL = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_BASE_URL/topstories.json?print=pretty');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_BASE_URL/item/$id.json?print=pretty');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}