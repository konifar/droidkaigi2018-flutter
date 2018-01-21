import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/api/droidkaigi_api_impl.dart';
import 'package:droidkaigi2018/repository/favorite_repository.dart';
import 'package:droidkaigi2018/repository/favorite_repository_impl.dart';
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

  Firestore _firestore;

  SessionRepository _sessionRepository;

  RoomRepository _roomRepository;

  FavoriteRepository _favoriteRepository;

  RepositoryFactory._internal() {
    _api = new DroidKaigiApiImpl();
    _firestore = Firestore.instance;
    _sessionRepository = new SessionRepositoryImpl(_api, new Map());
    _roomRepository = new RoomRepositoryImpl(_api, new Map());
    _favoriteRepository = new FavoriteRepositoryImpl(_firestore, new Map());
  }

  SessionRepository getSessionRepository() {
    return _sessionRepository;
  }

  RoomRepository getRoomRepository() {
    return _roomRepository;
  }

  FavoriteRepository getFavoriteRepository() {
    return _favoriteRepository;
  }
}
