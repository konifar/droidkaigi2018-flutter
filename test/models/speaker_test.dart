import 'dart:convert';

import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockSession extends Mock implements Session {}

void main() {
  group("fromJson", () {
    test('works well.', () {
      // given
      var json = JSON.decode("""
    {
      "id": "903eaf98-bf70-42a1-80da-6af3c5ec6668",
      "firstName": "",
      "lastName": "",
      "bio": "Engineer",
      "tagLine": "doraemon",
      "profilePicture": "https://sessionize.com/image?f=afd0e1c9743bf6de07b4a003b93ef4dc,200,200,True,False,50a020e5-f98f-41bd-b182-acc2b902a920.jpg",
      "isTopSpeaker": false,
      "links": [
        {
          "title": "Twitter",
          "url": "https://twitter.com/konifar",
          "linkType": "Twitter"
        }
      ],
      "sessions": [
        17028
      ],
      "fullName": "konifar"
    }
      """);

      Map<int, Session> sessionMap = new Map();
      Session session = new MockSession();
      sessionMap[17028] = session;

      // when
      Speaker speaker = Speaker.fromJson(json, sessionMap);

      // then
      expect(speaker.id, "903eaf98-bf70-42a1-80da-6af3c5ec6668");
      expect(speaker.bio, 'Engineer');
      expect(speaker.tagLine, 'doraemon');
      expect(speaker.profilePicture,
          'https://sessionize.com/image?f=afd0e1c9743bf6de07b4a003b93ef4dc,200,200,True,False,50a020e5-f98f-41bd-b182-acc2b902a920.jpg');
      expect(speaker.isTopSpeaker, isFalse);
      expect(speaker.links, hasLength(1));
      expect(speaker.links[0].url, 'https://twitter.com/konifar');
      expect(speaker.sessions, hasLength(1));
      expect(speaker.sessions[0], session);
      expect(speaker.fullName, 'konifar');
    });
  });
}
