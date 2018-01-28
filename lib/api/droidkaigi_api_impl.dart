import 'dart:async';
import 'dart:convert';

import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/models/category_item.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:http/http.dart' as http;

class DroidKaigiApiImpl implements DroidKaigiApi {
  static const _BASE_URL = 'https://droidkaigi.jp/2018/sessionize';

  var _categoryMap = new Map<int, Map<int, CategoryItem>>();
  var _roomMap = new Map<int, Room>();
  var _sessionMap = new Map<int, Session>();
  var _speakerMap = new Map<String, Speaker>();

  @override
  Future<Map<int, Session>> getSessions({bool refresh = false}) async {
    if (refresh || _sessionMap.isEmpty) {
      await _requestAll();
    }
    return _sessionMap;
  }

  @override
  Future<Map<String, Speaker>> getSpeakers({bool refresh = false}) async {
    if (refresh || _speakerMap.isEmpty) {
      await _requestAll();
    }
    return _speakerMap;
  }

  @override
  Future<Map<int, Room>> getRooms({bool refresh = false}) async {
    if (refresh || _roomMap.isEmpty) {
      await _requestAll();
    }
    return _roomMap;
  }

  _requestAll() async {
    var response = await http.read("$_BASE_URL/all.json");
    var json = JSON.decode(response);

    // Category
    var categories = json['categories'];
    for (var category in categories) {
      var categoryId = category['id'];
      Map itemMap = new Map<int, CategoryItem>();

      for (var item in category['items']) {
        itemMap[item['id']] = CategoryItem.fromJson(item, categoryId);
      }
      _categoryMap[categoryId] = itemMap;
    }

    // Room
    var rooms = json['rooms'];
    _roomMap[0] = new Room(Room.ID_ALL, "All", -1);
    for (var room in rooms) {
      // Sponsor room is not used.
      if (room['id'] != 521) {
        _roomMap[room['id']] = Room.fromJson(room);
      }
    }

    // Session
    var sessions = json['sessions'];
    for (var session in sessions) {
      _sessionMap[int.parse(session['id'])] =
          Session.fromJson(session, _categoryMap, _roomMap);
    }

    // Speaker
    var speakers = json['speakers'];
    for (var speaker in speakers) {
      _speakerMap[speaker['id']] = Speaker.fromJson(speaker, _sessionMap);
    }

    // Fill speakers in sessions
    for (var session in sessions) {
      for (var speakerId in session['speakers']) {
        _sessionMap[int.parse(session['id'])]
            .speakers
            .add(_speakerMap[speakerId]);
      }
    }
  }
}
