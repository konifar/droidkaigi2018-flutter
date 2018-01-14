import 'package:droidkaigi2018/models/link.dart';
import 'package:droidkaigi2018/models/session.dart';

class Speaker {
  Speaker(
      this.id,
      this.firstName,
      this.lastName,
      this.bio,
      this.tagLine,
      this.profilePicture,
      this.isTopSpeaker,
      this.links,
      this.sessions,
      this.fullName);

  final String id;
  final String firstName;
  final String lastName;
  final String bio;
  final String tagLine;
  final String profilePicture;
  final bool isTopSpeaker;
  final List<Link> links;
  final List<Session> sessions;
  final String fullName;

  static Speaker fromJson(json, Map<int, Session> sessionMap) {
    var speakerId = json['id'];
    var firstName = json['firstName'];
    var lastName = json['firstName'];
    var bio = json['bio'];
    var tagLine = json['tagLine'];
    var profilePicture = json['profilePicture'];
    var isTopSpeaker = json['isTopSpeaker'];
    var fullName = json['fullName'];

    var sessions = [];
    for (var sessionId in json['sessions']) {
      sessions.add(sessionMap[sessionId]);
    }

    var links = [];
    for (var link in json['links']) {
      links.add(Link.fromJson(link));
    }

    return new Speaker(speakerId, firstName, lastName, bio, tagLine,
        profilePicture, isTopSpeaker, links, sessions, fullName);
  }
}
