import 'package:droidkaigi2018/models/level.dart';
import 'package:flutter/widgets.dart';

const String _icNiche = 'assets/ic_niche_cyan_20.png';
const String _icSenior = 'assets/ic_intermediate_senior_bluegray_20.png';
const String _icBeginner = 'assets/ic_beginner_lightgreen_20.png';

class LevelImage {
  static AssetImage getAssetImage(Level level) {
    String lankIcon = _icBeginner;
    if (level.isBeginner()) {
      lankIcon = _icBeginner;
    } else if (level.isSenior()) {
      lankIcon = _icSenior;
    } else if (level.isNiche()) {
      lankIcon = _icNiche;
    }

    return new AssetImage(lankIcon);
  }
}
