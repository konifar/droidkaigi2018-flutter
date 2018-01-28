import 'dart:async';

import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  DroidKaigiApi _api;

  Map<int, Session> _cache = new Map();

  bool isDirty = true;

  SessionRepositoryImpl(this._api, this._cache);

  @override
  Future<List<Session>> findAll() {
    if (!isDirty && _cache.isNotEmpty) {
      return new Future.value(_cache.values.toList());
    }
    return _api.getSessions().then((sessions) {
      isDirty = false;
      _cache = sessions;
      return sessions.values.toList();
    });
  }

  @override
  Future<Session> find(int id) {
    if (!isDirty && _cache.containsKey(id)) {
      return new Future.value(_cache[id]);
    }
    return _api.getSessions().then((sessions) {
      _cache = sessions;
      return sessions[id];
    }).then((session) {
      isDirty = false;
      return session;
    });
  }

  @override
  Future<List<Session>> findByIds(List<int> ids) {
    _cache.values.where((session) => ids.contains(session.id)).toList();
    if (!isDirty && _cache.isNotEmpty) {
      var session = _cache.values
          .where((session) => ids.contains(int.parse(session.id)))
          .toList();
      return new Future.value(session);
    }
    return _api.getSessions().then((sessions) {
      _cache = sessions;
      return sessions.values
          .where((session) => ids.contains(int.parse(session.id)))
          .toList();
    }).then((sessions) {
      isDirty = false;
      return sessions;
    });
  }

  @override
  Future<List<Session>> findByRoom(int roomId) {
    return findAll().then((sessions) {
      return sessions.where((session) => session.room?.id == roomId).toList();
    });
  }
}
