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

  final int id;
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
}
