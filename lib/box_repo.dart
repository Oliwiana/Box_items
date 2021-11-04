import 'package:amplify_flutter/amplify.dart';
import 'package:box_of_items/models/BoxItem.dart';

class BoxRepository {
  Future<List<BoxItem>> getItems() async {
    try {
      final boxItems = await Amplify.DataStore.query(BoxItem.classType);
      return boxItems;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createItem(String name) async {
    final newItem = BoxItem(name: name, complete: false);
    try {
      await Amplify.DataStore.save(newItem);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateItemComplete(BoxItem boxItem, bool complete) async {
    final updatedItem = boxItem.copyWith(complete: complete);
    try {
      await Amplify.DataStore.save(updatedItem);
    } catch (e) {
      throw e;
    }
  }

  Stream observeItems() {
    return Amplify.DataStore.observe(BoxItem.classType);
  }
}
