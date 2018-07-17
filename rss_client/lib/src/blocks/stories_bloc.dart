import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/itemModel.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  // getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;


  // getters to Sinks
  Function(int) get fetchItem => _items.sink.add; // alias to function

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, _) {
          cache[id] = _repository.fetchItem(id);
          return cache;
        },
        <int, Future<ItemModel>> {}, // start object
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
