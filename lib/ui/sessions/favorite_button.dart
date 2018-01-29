import 'dart:async';

import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FavoriteButton extends StatefulWidget {
  final Session session;
  final GoogleSignIn googleSignIn;
  final bool favorite;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inActiveColor;

  FavoriteButton({
    Key key,
    @required this.session,
    @required this.googleSignIn,
    @required this.favorite,
    @required this.onChanged,
    this.activeColor,
    this.inActiveColor,
  })
      : super(key: key);

  @override
  _FavoriteButtonState createState() => new _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new IconButton(
      icon: (widget.favorite
          ? new Icon(
              Icons.favorite,
              color: widget.activeColor != null
                  ? widget.activeColor
                  : theme.primaryColor,
            )
          : new Icon(
              Icons.favorite_border,
              color: widget.inActiveColor != null
                  ? widget.inActiveColor
                  : Colors.grey[500],
            )),
      onPressed: () => _toggleFavorite(widget.session),
    );
  }

  Future<Null> _toggleFavorite(Session session) async {
    await _ensureLoggedIn(widget.googleSignIn);
    GoogleSignInAccount user = widget.googleSignIn.currentUser;
    if (user != null) {
      await _updateFavorite(widget.googleSignIn, session, !widget.favorite);
      widget.onChanged(!widget.favorite);
    }
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

  Future<Null> _updateFavorite(
      GoogleSignIn googleSignIn, Session session, bool favorite) async {
    await _ensureLoggedIn(googleSignIn);
    GoogleSignInAccount user = googleSignIn.currentUser;

    await new RepositoryFactory()
        .getFavoriteRepository()
        .update(user.id, session.id, favorite);
  }
}
