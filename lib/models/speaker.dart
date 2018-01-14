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
}
