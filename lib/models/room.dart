import 'package:droidkaigi2018/models/category_item.dart';

class Room extends CategoryItem {
  static const int ID_ALL = -1;

  final int sort;

  const Room(id, name, this.sort) : super(id, name);

  static Room fromJson(json) {
    return new Room(json['id'], json['name'], json['sort']);
  }
}
