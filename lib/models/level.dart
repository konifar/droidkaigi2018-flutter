import 'package:droidkaigi2018/models/category_item.dart';

class Level extends CategoryItem {
  const Level(id, name) : super(id, name);

  bool isBeginner() {
    return id == 3540;
  }

  bool isSenior() {
    return id == 3541;
  }

  bool isNiche() {
    return id == 3542;
  }
}
