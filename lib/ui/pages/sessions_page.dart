import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:droidkaigi2018/ui/pages/session_item.dart';
import 'package:flutter/material.dart';

class RoomSessionsPage extends StatefulWidget {
  final int roomId;

  RoomSessionsPage(this.roomId);

  @override
  _RoomSessionsPageState createState() => new _RoomSessionsPageState(roomId);
}

class _RoomSessionsPageState extends State<RoomSessionsPage> {
  List<Session> _sessions = [];
  final int roomId;

  _RoomSessionsPageState(this.roomId);

  @override
  void initState() {
    super.initState();

    new RepositoryFactory()
        .getSessionRepository()
        .findByRoom(roomId)
        .then((s) => setSessions(s));
  }

  @override
  Widget build(BuildContext context) {
    if (_sessions.isEmpty) {
      return new Center(
        child: const CircularProgressIndicator(),
      );
    }

    return new ListView(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      children: _sessions.map((Session session) {
        return new Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: new SessionsItem(session),
        );
      }).toList(),
    );
  }

  void setSessions(List<Session> sessions) {
    setState(() => _sessions = sessions);
  }
}
