import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droidkaigi2018/repository/favorite_repository.dart';

/*
 * users: Collection
 *  ├ user_id: Document
 *    ├ favorites: Collection
 *      ├ session_id: Document
 *        ├ {favorite:true}: Field
 */
class FavoriteRepositoryImpl extends FavoriteRepository {
  // <sessionId, favorite>
  Map<String, bool> _cache = new Map();

  Firestore _firestore;

  bool isDirty = true;

  FavoriteRepositoryImpl(this._firestore, this._cache);

  Future<Map<String, bool>> findAll(String userId) async {
    if (!isDirty && _cache.isNotEmpty) {
      return new Future.value(_cache);
    }

    final Map<String, bool> result = new Map();
    final Stream<QuerySnapshot> snapshots =
        _firestore.collection("users/$userId/favorites").snapshots;

    await snapshots.first.then((snapshot) {
      snapshot.documents.forEach((DocumentSnapshot document) {
        String sessionId = document.documentID;
        bool favorite = document.data.values.toList()[0];
        result[sessionId] = favorite;
      });
    });

    _cache = result;
    return new Future.value(result);
  }

  Future<bool> find(String userId, String sessionId) async {
    if (!isDirty && _cache.containsKey(sessionId)) {
      return new Future.value(_cache[sessionId]);
    }

    final Stream<DocumentSnapshot> snapshots =
        _firestore.document("users/$userId/favorites/$sessionId").snapshots;

    return await snapshots.first.then((snapshot) {
      bool favorite = snapshot.data.values.toList()[0];
      _cache[sessionId] = favorite;
      return favorite;
    });
  }

  Future<Null> update(String userId, String sessionId, bool favorite) async {
    return await _firestore
        .collection("users/$userId/favorites")
        .document(sessionId)
        .setData({'favorite': favorite}).then((result) {
      _cache[sessionId] = favorite;
      return result;
    });
  }
}
