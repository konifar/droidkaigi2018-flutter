import 'dart:async';

import 'package:droidkaigi2018/models/room.dart';

abstract class RoomRepository {
  Future<Map<int, Room>> findAll();

  Future<Room> find(int id);
}
