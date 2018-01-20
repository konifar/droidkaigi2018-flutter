import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:droidkaigi2018/ui/pages/session_item.dart';
import 'package:flutter/material.dart';

class SessionsPage extends StatefulWidget {
  @override
  _SessionsPageState createState() => new _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  List<Session> _sessions = [];

  @override
  void initState() {
    super.initState();

    new RepositoryFactory()
        .getSessionRepository()
        .findAll()
        .then((s) => setSessions(s.values.toList()));
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
