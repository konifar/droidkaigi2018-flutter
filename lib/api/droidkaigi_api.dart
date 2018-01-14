import 'dart:async';

import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';

abstract class DroidKaigiApi {
  Future<Map<int, Session>> getSessions();

  Future<Map<String, Speaker>> getSpeakers();
}
