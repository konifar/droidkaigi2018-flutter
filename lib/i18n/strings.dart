import 'dart:async';

import 'package:droidkaigi2018/i18n/messages_all.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Strings {
  static Future<Strings> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((Null _) {
      Intl.defaultLocale = localeName;
      return new Strings();
    });
  }

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  static final Strings instance = new Strings();

  String get appName => Intl.message("DroidKaigi 2018", name: "appName");
  String get appDescription =>
      Intl.message("Feb,08 (Thu) - 09 (Fri)", name: "appDescription");
  String get allSessions => Intl.message("All Sessions", name: "allSessions");
  String get mySchedule => Intl.message("My Schedule", name: "mySchedule");
  String get map => Intl.message("Map", name: "map");
  String get access => Intl.message("Access", name: "access");
  String settings() => Intl.message("Settings", name: "settings");
  String sponsors() => Intl.message("Sponsors", name: "sponsors");
  String questionnaire() => Intl.message("Quesionnaire", name: "questionnaire");
  String about() => Intl.message("About", name: "about");
  String day(int day) => Intl.message("DAY$day", name: "day", args: [day]);
  String get mapPlaceName =>
      Intl.message("Bellesalle Shinjuku Grand Conference Center",
          name: "mapPlaceName");
  String get mapMeetingRoomsName =>
      Intl.message("DroidKaigi 2018 Place", name: "mapMeetingRoomsName");
  String get mapAddress => Intl.message(
      "Sumitomo Fudosan Shinjuku Grand Tower 5F 8-17-1 Nishi Shinjuku, Shinjuku City, Tokyo 160-0023",
      name: "mapAddress");
  String get mapNearbyStations => Intl.message(
      "Marunouchi subway line: 3 minutes walk from Nishi Shinjuku Station Gate No.1 Toei Oedo subway line: 7 minutes walk from Tochomae Station Gate E4 Toei Oedo subway line: 11 minutes walk from Shinjuku-Nishiguchi Station Gate D4 JR lines, Marunouchi/Toei Shinjuku/Toei Oedo subway line, Odakyu line, Keio line: 15 minutes walk from Shinjuku Station West Gate",
      name: "mapNearbyStations");
}
