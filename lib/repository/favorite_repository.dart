import 'dart:async';

abstract class FavoriteRepository {
  Future<Map<String, bool>> findAll(String userId);

  Future<bool> find(String userId, String sessionId);

  Future<Null> update(String userId, String sessionId, bool favorite);
}
