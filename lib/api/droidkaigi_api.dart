import 'dart:async';

import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';

abstract class DroidKaigiApi {
  Future<Map<int, Session>> getSessions({bool refresh});

  Future<Map<String, Speaker>> getSpeakers({bool refresh});

  Future<Map<int, Room>> getRooms({bool refresh});
}
