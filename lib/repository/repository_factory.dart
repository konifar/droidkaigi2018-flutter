import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/api/droidkaigi_api_impl.dart';
import 'package:droidkaigi2018/repository/room_repository.dart';
import 'package:droidkaigi2018/repository/room_repository_impl.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';
import 'package:droidkaigi2018/repository/session_repository_impl.dart';

class RepositoryFactory {
  static final RepositoryFactory _singleton = new RepositoryFactory._internal();

  factory RepositoryFactory() {
    return _singleton;
  }

  DroidKaigiApi _api;

  SessionRepository _sessionRepository;

  RoomRepository _roomRepository;

  RepositoryFactory._internal() {
    _api = new DroidKaigiApiImpl();
    _sessionRepository = new SessionRepositoryImpl(_api, new Map());
    _roomRepository = new RoomRepositoryImpl(_api, new Map());
  }

  SessionRepository getSessionRepository() {
    return _sessionRepository;
  }

  RoomRepository getRoomRepository() {
    return _roomRepository;
  }
}
