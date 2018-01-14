import 'package:droidkaigi2018/models/duration_type.dart';
import 'package:droidkaigi2018/models/language.dart';
import 'package:droidkaigi2018/models/level.dart';
import 'package:droidkaigi2018/models/topic.dart';

abstract class CategoryItem {
  const CategoryItem(this.id, this.name);

  static const int DURATION_TYPE_ID = 808;
  static const int LANGUAGE_ID = 809;
  static const int TOPIC_ID = 811;
  static const int LEVEL_ID = 824;

  final int id;
  final String name;

  static CategoryItem fromJson(json, int categoryId) {
    var itemId = json['id'];
    var itemName = json['name'];

    switch (categoryId) {
      case CategoryItem.DURATION_TYPE_ID:
        return new DurationType(itemId, itemName);
      case CategoryItem.LANGUAGE_ID:
        return new Language(itemId, itemName);
      case CategoryItem.TOPIC_ID:
        return new Topic(itemId, itemName);
      case CategoryItem.LEVEL_ID:
        return new Level(itemId, itemName);
      default:
        return null;
    }
  }
}
