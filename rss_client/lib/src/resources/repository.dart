import 'dart:async';
import 'newsApiProvider.dart';
import 'newsDbProvider.dart';
import '../models/itemModel.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
//      print(item.title);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
//      cache.addItem(item).catchError((e) => print(e));
      if (cache != source ) {
        cache.addItem(item).catchError((e) => print(e));
      }

    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }

}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}


