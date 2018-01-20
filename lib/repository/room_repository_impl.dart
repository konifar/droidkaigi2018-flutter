import 'dart:async';

import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  DroidKaigiApi _api;

  Map<int, Room> _cache = new Map();

  bool isDirty = true;

  RoomRepositoryImpl(this._api, this._cache);

  @override
  Future<Map<int, Room>> findAll() {
    if (!isDirty && _cache.isNotEmpty) {
      return new Future.value(_cache);
    }
    return _api.getRooms().then((rooms) {
      isDirty = false;
      return rooms;
    });
  }

  @override
  Future<Room> find(int id) {
    if (!isDirty && _cache.containsKey(id)) {
      return new Future.value(_cache[id]);
    }
    return findAll().then((sessions) => sessions[id]).then((room) {
      isDirty = false;
      return room;
    });
  }
}
