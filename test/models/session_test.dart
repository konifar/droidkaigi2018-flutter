import 'dart:convert';

import 'package:droidkaigi2018/models/category_item.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/topic.dart';
import 'package:test/test.dart';

void main() {
  group("fromJson", () {
    test('works well.', () {
      // given
      var json = JSON.decode("""
    {
      "id": "17028",
      "title": "コードで見るFlutterアプリの実装",
      "description": "FlutterはAndroid、iOS両方のアプリをDartで書けるフレームワークです。",
      "startsAt": "2018-02-09T17:40:00",
      "endsAt": "2018-02-09T18:10:00",
      "isServiceSession": false,
      "isPlenumSession": false,
      "speakers": [
        "903eaf98-bf70-42a1-80da-6af3c5ec6668"
      ],
      "categoryItems": [
        3480,
        3483,
        3499,
        3542
      ],
      "questionAnswers": [],
      "roomId": 516
    }
      """);

      Map<int, Map<int, CategoryItem>> categoryMap = new Map();
      Map<int, CategoryItem> itemMap = new Map();
      Topic topic = new Topic(3499, "マルチプラットフォーム / Platforms");
      itemMap[3499] = topic;
      categoryMap[811] = itemMap;

      Map<int, Room> roomMap = new Map();
      Room room = new Room(516, "Room 3 G + H", 3);
      roomMap[516] = room;

      // when
      Session session = Session.fromJson(json, categoryMap, roomMap);

      // then
      expect(session.id, '17028');
      expect(session.title, "コードで見るFlutterアプリの実装");
      expect(
          session.description, "FlutterはAndroid、iOS両方のアプリをDartで書けるフレームワークです。");
      expect(session.startsAt.minute, 40);
      expect(session.endsAt.minute, 10);
      expect(session.isServiceSession, isFalse);
      expect(session.isPlenumSession, isFalse);
      expect(session.speakers, isEmpty);
      expect(session.room, room);
      expect(session.topic, topic);
    });
  });
}
