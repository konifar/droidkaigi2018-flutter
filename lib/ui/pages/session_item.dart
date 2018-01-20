import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final ThemeData theme = Theme.of(context);
    final TextStyle timeStyle = theme.textTheme.caption;
    final TextStyle titleStyle = theme.textTheme.title;
    final TextStyle descriptionStyle = theme.textTheme.caption;
    final TextStyle speakerNameStyle = theme.textTheme.body2;

    final formatter =
        new DateFormat.Hm(Localizations.localeOf(context).languageCode);
    final startAt = formatter.format(_session.startsAt);
    final endAt = formatter.format(_session.endsAt);

    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              "$startAt - $endAt / ${_session.room.name}",
              style: timeStyle,
            ),
            new Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text(_session.title, style: titleStyle)),
            new DefaultTextStyle(
              style: descriptionStyle,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              child: new Padding(
                child: new Text(_session.description),
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              ),
            ),
            new Text(_session.topic.name, style: descriptionStyle),
            new Padding(
              child: new Column(
                children:
                    _createSpeakerRows(_session.speakers, speakerNameStyle),
              ),
              padding: const EdgeInsets.only(top: 8.0),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> _createSpeakerRows(
    List<Speaker> speakers, TextStyle speakerNameStyle) {
  return speakers.map((speaker) {
    return new Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Row(
        children: [
          new SizedBox(
            width: 32.0,
            height: 32.0,
            child: new CircleAvatar(
              backgroundImage: new NetworkImage(speaker.profilePicture),
            ),
          ),
          new Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(speaker.fullName, style: speakerNameStyle)),
        ],
      ),
    );
  }).toList();
}
