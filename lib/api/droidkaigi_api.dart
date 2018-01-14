import 'dart:async';

import 'package:droidkaigi2018/models/session.dart';

abstract class DroidKaigiApi {
  Future<Map<int, Session>> getSessions();
}
