import 'dart:async';

import 'package:droidkaigi2018/models/session.dart';

abstract class SessionRepository {
  Future<List<Session>> findAll();

  Future<Session> find(int id);

  Future<List<Session>> findByRoom(int roomId);
}
