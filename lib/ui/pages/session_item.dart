import 'package:droidkaigi2018/models/session.dart';
import 'package:flutter/material.dart';

class SessionsItem extends StatefulWidget {
  SessionsItem(this._session);

  final Session _session;

  @override
  _SessionsItemState createState() => new _SessionsItemState(_session);
}

class _SessionsItemState extends State<SessionsItem> {
  Session _session;

  _SessionsItemState(this._session);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: new CircleAvatar(child: new Text('${_session.title}')),
            ),
            new Center(
              child: new Text(_session.title,
                  style: Theme.of(context).textTheme.title),
            ),
          ],
        ),
      ),
    );
  }
}
