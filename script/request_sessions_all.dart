import 'dart:convert';

import 'package:droidkaigi2018/models/category.dart';
import 'package:droidkaigi2018/models/duration_type.dart';
import 'package:droidkaigi2018/models/language.dart';
import 'package:droidkaigi2018/models/level.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:droidkaigi2018/models/topic.dart';
import 'package:http/http.dart' as http;

main() async {
  var durationTypeMap = new Map<int, DurationType>();
  var languageMap = new Map<int, Language>();
  var topicMap = new Map<int, Topic>();
  var levelMap = new Map<int, Level>();
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

    for (var item in category['items']) {
      var itemId = item['id'];
      var itemName = item['name'];

      switch (categoryId) {
        case Category.DURATION_TYPE_ID:
          durationTypeMap[itemId] = new DurationType(itemId, itemName);
          break;
        case Category.LANGUAGE_ID:
          languageMap[itemId] = new Language(itemId, itemName);
          break;
        case Category.TOPIC_ID:
          topicMap[itemId] = new Topic(itemId, itemName);
          break;
        case Category.LEVEL_ID:
          levelMap[itemId] = new Level(itemId, itemName);
          break;
      }
    }
  }

  // Room
  var rooms = json['rooms'];
  for (var room in rooms) {
    roomMap[room['id']] = Room.fromJson(room);
  }

  // Session
  var sessions = json['sessions'];
  for (var session in sessions) {
    var sessionId = session['id'];
    var title = session['title'];
    var description = session['description'];
    var startsAt = DateTime.parse(session['startsAt']);
    var endsAt = DateTime.parse(session['endsAt']);
    var isServiceSession = session['isServiceSession'];
    var isPlenumSession = session['isPlenumSession'];
    var speakers = [];
    var room = roomMap[session['roomId']];

    DurationType durationType;
    Level level;
    Language language;
    Topic topic;

    for (var itemId in session['categoryItems']) {
      if (durationType == null) {
        durationType = durationTypeMap[itemId];
      }
      if (level == null) {
        level = levelMap[itemId];
      }
      if (language == null) {
        language = languageMap[itemId];
      }
      if (topic == null) {
        topic = topicMap[itemId];
      }
    }

    sessionMap[sessionId] = new Session(
        sessionId,
        title,
        description,
        startsAt,
        endsAt,
        isServiceSession,
        isPlenumSession,
        speakers,
        room,
        durationType,
        topic,
        level,
        language);
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
