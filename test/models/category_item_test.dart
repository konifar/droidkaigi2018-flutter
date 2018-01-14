import 'dart:convert';

import 'package:droidkaigi2018/models/category_item.dart';
import 'package:droidkaigi2018/models/duration_type.dart';
import 'package:droidkaigi2018/models/language.dart';
import 'package:droidkaigi2018/models/level.dart';
import 'package:droidkaigi2018/models/topic.dart';
import 'package:test/test.dart';

void main() {
  group("fromJson", () {
    test('when category id is duration_type', () {
      // given
      var json = JSON.decode("""
        {
          "id": 3480,
          "name": "30minutes",
          "sort": 1
        }
      """);

      // when
      CategoryItem categoryItem = CategoryItem.fromJson(json, 808);

      // then
      expect(categoryItem.id, 3480);
      expect(categoryItem.name, '30minutes');
      expect(categoryItem, new isInstanceOf<DurationType>());
    });

    test('when category id is language', () {
      // given
      var json = JSON.decode("""
        {
          "id": 3483,
          "name": "日本語",
          "sort": 1
        }
      """);

      // when
      CategoryItem categoryItem = CategoryItem.fromJson(json, 809);

      // then
      expect(categoryItem.id, 3483);
      expect(categoryItem.name, '日本語');
      expect(categoryItem, new isInstanceOf<Language>());
    });

    test('when category id is topic', () {
      // given
      var json = JSON.decode("""
        {
          "id": 3487,
          "name": "UI・トピック / UI and Design",
          "sort": 1
        }
      """);

      // when
      CategoryItem categoryItem = CategoryItem.fromJson(json, 811);

      // then
      expect(categoryItem.id, 3487);
      expect(categoryItem.name, 'UI・トピック / UI and Design');
      expect(categoryItem, new isInstanceOf<Topic>());
    });

    test('when category id is level', () {
      // given
      var json = JSON.decode("""
        {
          "id": 3540,
          "name": "初心者向け / for beginners",
          "sort": 1
        }
      """);

      // when
      CategoryItem categoryItem = CategoryItem.fromJson(json, 824);

      // then
      expect(categoryItem.id, 3540);
      expect(categoryItem.name, '初心者向け / for beginners');
      expect(categoryItem, new isInstanceOf<Level>());
    });
  });
}
