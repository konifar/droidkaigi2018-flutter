import 'dart:async';

import 'package:dice/dice.dart';
import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  @inject
  DroidKaigiApi _api;

  Map<int, Session> _cache = new Map();

  bool isDirty;

  @override
  Future<Map<int, Session>> findAll() {
    if (!isDirty && _cache.isNotEmpty) {
      return new Future.value(_cache);
    }
    return _api.getSessions().then((sessions) {
      isDirty = false;
    });
  }

  @override
  Future<Session> find(int id) {
    if (!isDirty && _cache.containsKey(id)) {
      return new Future.value(_cache[id]);
    }
    return _api.getSessions().then((sessions) => sessions[id]).then((session) {
      isDirty = false;
    });
  }
}
