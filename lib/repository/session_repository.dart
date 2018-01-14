import 'dart:async';

import 'package:dice/dice.dart';
import 'package:droidkaigi2018/models/session.dart';

@injectable
abstract class SessionRepository {
  Future<Map<int, Session>> findAll();

  Future<Session> find(int id);
}
