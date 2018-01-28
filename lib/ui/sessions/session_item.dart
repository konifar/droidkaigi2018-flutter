import 'dart:async';

import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:droidkaigi2018/ui/sessions/favorite_button.dart';
import 'package:droidkaigi2018/ui/sessions/level_image.dart';
import 'package:droidkaigi2018/ui/sessions/room_sessions_page.dart';
import 'package:droidkaigi2018/ui/sessions/session_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class SessionsItem extends StatefulWidget {
  const SessionsItem({
    Key key,
    @required this.session,
    this.googleSignIn,
  })
      : assert(session != null),
        super(key: key);

  final Session session;
  final GoogleSignIn googleSignIn;

  @override
  _SessionsItemState createState() => new _SessionsItemState();
}

class _SessionsItemState extends State<SessionsItem> {
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
    fetchFavorite(widget.googleSignIn);
  }

  Future<Null> _showDetailPage(Session session) async {
    await Navigator.push(
      context,
      new SessionPageRoute(
        session: session,
        builder: (BuildContext context) {
          return new SessionDetail(
            session: session,
            favorite: _favorite,
            googleSignIn: googleSignIn,
            onFavoriteChanged: (value) => setState(() => _favorite = value),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle timeStyle = theme.textTheme.caption.merge(
      const TextStyle(fontWeight: FontWeight.bold),
    );
    final TextStyle titleStyle = theme.textTheme.title;
    final TextStyle descriptionStyle = theme.textTheme.caption.merge(
      const TextStyle(color: Colors.black),
    );
    final TextStyle topicStyle = theme.textTheme.caption;
    final TextStyle speakerNameStyle = theme.textTheme.body2;

    final Session _session = widget.session;

    final formatter =
        new DateFormat.Hm(Localizations.localeOf(context).languageCode);
    final startAt = formatter.format(_session.startsAt);
    final endAt = formatter.format(_session.endsAt);

    return new Card(
      child: new InkWell(
        onTap: () => _showDetailPage(_session),
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Stack(
            children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "${Strings.of(context).day(widget.session.getDay())}   $startAt - $endAt / ${_session.room.name}",
                    style: timeStyle,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: new Text(_session.title, style: titleStyle)),
                  new DefaultTextStyle(
                    style: descriptionStyle,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    child: new Padding(
                      child: new Text(_session.description),
                      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    ),
                  ),
                  new Row(
                    children: [
                      new Container(
                        width: 24.0,
                        height: 24.0,
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: LevelImage.getAssetImage(_session.level),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          _session.topic.name,
                          style: topicStyle,
                        ),
                      ),
                    ],
                  ),
                  new Padding(
                    child: new Column(
                      children: _createSpeakerRows(
                          _session.speakers, speakerNameStyle),
                    ),
                    padding: const EdgeInsets.only(top: 8.0),
                  )
                ],
              ),
              new Positioned(
                bottom: -8.0,
                right: -8.0,
                child: new FavoriteButton(
                  session: _session,
                  googleSignIn: googleSignIn,
                  favorite: _favorite,
                  onChanged: (value) {
                    setState(() => _favorite = value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> fetchFavorite(GoogleSignIn googleSignIn) async {
    await _ensureLoggedIn(googleSignIn);
    GoogleSignInAccount user = googleSignIn.currentUser;

    new RepositoryFactory()
        .getFavoriteRepository()
        .findAll(user.id)
        .then((Map<String, bool> result) {
      setState(() {
        _favorite = result[widget.session.id] == true;
      });
    });
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

Future<Null> _ensureLoggedIn(GoogleSignIn googleSignIn) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    await googleSignIn.signIn();
  }
}
