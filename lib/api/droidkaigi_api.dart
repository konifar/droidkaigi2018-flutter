import 'dart:async';

import 'package:dice/dice.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';

@injectable
abstract class DroidKaigiApi {
  Future<Map<int, Session>> getSessions();

  Future<Map<String, Speaker>> getSpeakers();
}
