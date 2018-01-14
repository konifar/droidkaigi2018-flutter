import 'dart:async';

import 'package:droidkaigi2018/models/session.dart';

abstract class SessionRepository {
  Future<Map<int, Session>> findAll();

  Future<Session> find(int id);
}
