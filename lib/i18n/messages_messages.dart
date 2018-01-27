// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  static m0(day) => "DAY${day}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "allSessions" : MessageLookupByLibrary.simpleMessage("All Sessions"),
    "appName" : MessageLookupByLibrary.simpleMessage("DroidKaigi 2018"),
    "day" : m0,
    "map" : MessageLookupByLibrary.simpleMessage("Map"),
    "mySchedule" : MessageLookupByLibrary.simpleMessage("My Schedule"),
    "questionnaire" : MessageLookupByLibrary.simpleMessage("Quesionnaire"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "sponsors" : MessageLookupByLibrary.simpleMessage("Sponsors")
  };
}
