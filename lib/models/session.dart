import 'package:droidkaigi2018/models/category_item.dart';
import 'package:droidkaigi2018/models/duration_type.dart';
import 'package:droidkaigi2018/models/language.dart';
import 'package:droidkaigi2018/models/level.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:droidkaigi2018/models/topic.dart';

class Session {
  const Session(
      this.id,
      this.title,
      this.description,
      this.startsAt,
      this.endsAt,
      this.isServiceSession,
      this.isPlenumSession,
      this.speakers,
      this.room,
      this.durationType,
      this.topic,
      this.level,
      this.language);

  final String id;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isServiceSession;
  final bool isPlenumSession;
  final List<Speaker> speakers;
  final Room room;
  final DurationType durationType;
  final Topic topic;
  final Level level;
  final Language language;

  int getDay() {
    // DroidKaigi is held on 2/8 (Thu), 2/9 (Fri)
    return startsAt.day == 8 ? 1 : 2;
  }

  static fromJson(json, Map<int, Map<int, CategoryItem>> categoryMap,
      Map<int, Room> roomMap) {
    var sessionId = json['id'];
    var title = json['title'];
    var description = json['description'];
    var startsAt = DateTime.parse(json['startsAt']);
    var endsAt = DateTime.parse(json['endsAt']);
    var isServiceSession = json['isServiceSession'];
    var isPlenumSession = json['isPlenumSession'];
    var speakers = [];
    var room = roomMap[json['roomId']];

    DurationType durationType;
    Level level;
    Language language;
    Topic topic;

    for (var itemId in json['categoryItems']) {
      if (durationType == null) {
        if (categoryMap[CategoryItem.DURATION_TYPE_ID] != null) {
          durationType = categoryMap[CategoryItem.DURATION_TYPE_ID][itemId];
        }
      }
      if (level == null) {
        if (categoryMap[CategoryItem.LEVEL_ID] != null) {
          level = categoryMap[CategoryItem.LEVEL_ID][itemId];
        }
      }
      if (language == null) {
        if (categoryMap[CategoryItem.LANGUAGE_ID] != null) {
          language = categoryMap[CategoryItem.LANGUAGE_ID][itemId];
        }
      }
      if (topic == null) {
        if (categoryMap[CategoryItem.TOPIC_ID] != null) {
          topic = categoryMap[CategoryItem.TOPIC_ID][itemId];
        }
      }
    }

    return new Session(
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
}
