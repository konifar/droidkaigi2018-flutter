import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/session_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDroidKaigiApi extends Mock implements DroidKaigiApi {}

class MockSession extends Mock implements Session {}

void main() {
  DroidKaigiApi _api;
  Map<int, Session> _cache;
  SessionRepositoryImpl _subject;

  setUp(() {
    _api = new MockDroidKaigiApi();
    _cache = new Map();
    _subject = new SessionRepositoryImpl(_api, _cache);
  });

  group("findAll", () {
    test('when isDirty is true, findAll() calls api method.', () async {
      // given
      when(_api.getSessions()).thenReturn(new Future(() => []));

      // when
      await _subject.findAll();

      // then
      verify(_api.getSessions());
      expect(_subject.isDirty, false);
    });

    test('when isDirty is false, findAll() returns cached value.', () async {
      // given
      _cache[1] = new MockSession();
      _subject.isDirty = false;

      // when
      // then
      await _subject.findAll().then((sessions) {
        expect(sessions, hasLength(1));
      });
      verifyNever(_api.getSessions());
      expect(_subject.isDirty, false);
    });

    test('when cache is empty, findAll() calls api method.', () async {
      // given
      when(_api.getSessions()).thenReturn(new Future(() => []));
      _subject.isDirty = false;

      // when
      await _subject.findAll();
      // then
      verify(_api.getSessions());
      expect(_subject.isDirty, false);
    });
  });

  group("find", () {
    test('when isDirty is true, find() calls api method.', () async {
      // given
      var session = new MockSession();
      Map<int, Session> sessions = new Map();
      sessions[1] = session;
      when(_api.getSessions()).thenReturn(new Future(() => sessions));

      // when
      await _subject.find(1).then((actual) {
        expect(actual, session);
      });

      // then
      verify(_api.getSessions());
      expect(_subject.isDirty, false);
    });

    test('when isDirty is false, find() returns cached value.', () async {
      // given
      var session = new MockSession();
      _cache[1] = session;
      _subject.isDirty = false;

      // when
      // then
      await _subject.find(1).then((actual) {
        expect(actual, session);
      });
      verifyNever(_api.getSessions());
      expect(_subject.isDirty, false);
    });

    test('when the session is nothing, find() returns null value.', () async {
      // given
      var session = new MockSession();
      Map<int, Session> sessions = new Map();
      sessions[1] = session;
      when(_api.getSessions()).thenReturn(new Future(() => sessions));

      // when
      // then
      await _subject.find(2).then((actual) {
        expect(actual, isNull);
      });
    });
  });

  group("findByRoom", () {
    test('when one room matches', () async {
      // given
      var session = new MockSession();
      var room = new Room(1, "Room1", 1);
      when(session.room).thenReturn(room);
      when(_api.getSessions()).thenReturn(new Future(() => {1: session}));

      // when
      // then
      await _subject.findByRoom(1).then((sessions) {
        expect(sessions, hasLength(1));
      });
    });

    test('when no room matches', () async {
      // given
      var session = new MockSession();
      var room = new Room(1, "Room1", 1);
      when(session.room).thenReturn(room);
      when(_api.getSessions()).thenReturn(new Future(() => {1: session}));

      // when
      // then
      await _subject.findByRoom(2).then((sessions) {
        expect(sessions, isEmpty);
      });
    });
  });
}
