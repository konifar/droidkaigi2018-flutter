import 'package:droidkaigi2018/models/category.dart';

class Room extends Category {
  final int sort;

  const Room(id, name, this.sort) : super(id, name);

  static Room fromJson(json) {
    return new Room(json['id'], json['name'], json['sort']);
  }
}
