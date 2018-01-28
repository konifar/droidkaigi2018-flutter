import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:droidkaigi2018/ui/sessions/session_item.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

final googleSignIn = new GoogleSignIn();

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

    if (roomId == Room.ID_ALL) {
      new RepositoryFactory()
          .getSessionRepository()
          .findAll()
          .then((s) => setSessions(s));
    } else {
      new RepositoryFactory()
          .getSessionRepository()
          .findByRoom(roomId)
          .then((s) => setSessions(s));
    }
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
          child: new SessionsItem(
            session: session,
            googleSignIn: googleSignIn,
          ),
        );
      }).toList(),
    );
  }

  void setSessions(List<Session> sessions) {
    setState(() => _sessions = sessions);
  }
}

class SessionPageRoute<Session> extends MaterialPageRoute {
  SessionPageRoute({
    @required this.session,
    WidgetBuilder builder,
    RouteSettings settings: const RouteSettings(),
  })
      : super(builder: builder, settings: settings);

  Session session;

  @override
  Session get currentResult => session;
}
