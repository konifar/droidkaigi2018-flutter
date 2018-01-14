import 'dart:convert';

import 'package:droidkaigi2018/models/category_item.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:http/http.dart' as http;

main() async {
  var categoryMap = new Map<int, Map<int, CategoryItem>>();
  var roomMap = new Map<int, Room>();
  var sessionMap = new Map<int, Session>();
  var speakerMap = new Map<String, Speaker>();

  var response =
      await http.read('https://droidkaigi.jp/2018/sessionize/all.json');
  var json = JSON.decode(response);

  // Category
  var categories = json['categories'];
  for (var category in categories) {
    var categoryId = category['id'];
    Map itemMap = new Map<int, CategoryItem>();

    for (var item in category['items']) {
      itemMap[item['id']] = CategoryItem.fromJson(item, categoryId);
    }
    categoryMap[categoryId] = itemMap;
  }

  // Room
  var rooms = json['rooms'];
  for (var room in rooms) {
    roomMap[room['id']] = Room.fromJson(room);
  }

  // Session
  var sessions = json['sessions'];
  for (var session in sessions) {
    sessionMap[session['id']] = Session.fromJson(session, categoryMap, roomMap);
  }

  // Speaker
  var speakers = json['speakers'];
  for (var speaker in speakers) {
    speakerMap[speaker['id']] = Speaker.fromJson(speaker, sessionMap);
  }

  // Fill speakers in sessions
  for (var session in sessions) {
    for (var speakerId in session['speakers']) {
      sessionMap[session['id']].speakers.add(speakerMap[speakerId]);
    }
  }
}
