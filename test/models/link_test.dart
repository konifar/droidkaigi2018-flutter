import 'dart:convert';

import 'package:droidkaigi2018/models/link.dart';
import 'package:test/test.dart';

void main() {
  group("fromJson", () {
    test('works well.', () {
      // given
      var json = JSON.decode("""
{
  "linkType": "Twitter",
  "url": "https://twitter.com/konifar"
}
      """);

      // when
      Link link = Link.fromJson(json);

      // then
      expect(link.type, LinkType.twitter);
      expect(link.url, 'https://twitter.com/konifar');
    });
  });
}
