import 'dart:convert';

import 'package:droidkaigi2018/models/room.dart';
import 'package:test/test.dart';

void main() {
  group("fromJson", () {
    test('works well.', () {
      // given
      var json = JSON.decode("""
    {
      "id": 513,
      "name": "Hall",
      "sort": 0
    }
      """);

      // when
      Room room = Room.fromJson(json);

      // then
      expect(room.id, 513);
      expect(room.name, 'Hall');
      expect(room.sort, 0);
    });
  });
}
