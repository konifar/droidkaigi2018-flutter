import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:droidkaigi2018/theme.dart';
import 'package:droidkaigi2018/ui/sessions/favorite_button.dart';
import 'package:droidkaigi2018/ui/sessions/level_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class SessionDetail extends StatefulWidget {
  SessionDetail({
    Key key,
    @required this.session,
    @required this.favorite,
    @required this.googleSignIn,
    @required this.onFavoriteChanged,
  })
      : assert(session != null),
        assert(favorite != null),
        assert(onFavoriteChanged != null),
        super(key: key);

  final Session session;
  final GoogleSignIn googleSignIn;
  final ValueChanged<bool> onFavoriteChanged;
  bool favorite;

  @override
  _SessionDetailState createState() => new _SessionDetailState();
}

const double _kAppBarHeight = 320.0;

const String _imgHeader = 'assets/img_drawer_header.png';

class _SessionDetailState extends State<SessionDetail> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  ScrollController _hideFabController;

  bool _isFabVisible;

  @override
  void initState() {
    super.initState();
    _isFabVisible = true;
    _hideFabController = new ScrollController();
    _hideFabController.addListener(() {
      if (_hideFabController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isFabVisible = false;
        });
      }
      if (_hideFabController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _hideFabController.dispose();
    super.dispose();
  }

  List<Widget> _buildSpeakerRows(
      List<Speaker> speakers, TextStyle speakerNameStyle) {
    return speakers.map((speaker) {
      return new Container(
        padding: new EdgeInsets.only(top: 8.0),
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

  Widget _buildAppBar(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final ThemeData theme = Theme.of(context);

    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      flexibleSpace: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = constraints.biggest;
        final double appBarHeight = size.height - statusBarHeight;
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);

        return new Stack(
          children: [
            _buildBackgroundImage(statusBarHeight, t),
            _buildHeaderContents(size, t, theme),
            _buildAppBarFixedTitle(statusBarHeight, t, theme),
          ],
        );
      }),
    );
  }

  /*
   * When the user scroll up, this appbar title is shown with fade animation.
   */
  Widget _buildAppBarFixedTitle(
      double statusBarHeight, double t, ThemeData theme) {
    final TextStyle titleStyle = theme.textTheme.title.merge(new TextStyle(
      color: Colors.white,
    ));

    final Curve _textOpacity =
        const Interval(0.4, 1.0, curve: Curves.easeInOut);

    final Size screenSize = MediaQuery.of(context).size;
    // kToolbarHeight equals the left icon width
    final double titleWidth =
        screenSize.width - kToolbarHeight - NavigationToolbar.kMiddleSpacing;

    final iOS = Theme.of(context).platform == TargetPlatform.iOS;

    return new Positioned.fromRect(
      rect: new Rect.fromLTWH(
        iOS
            ? kToolbarHeight - NavigationToolbar.kMiddleSpacing
            : kToolbarHeight,
        statusBarHeight,
        titleWidth,
        kToolbarHeight,
      ),
      child: new Container(
        alignment: iOS ? Alignment.center : Alignment.centerLeft,
        child: new Opacity(
          opacity: _textOpacity.transform(1 - t.clamp(0.0, 1.0)),
          child: new Text(
            widget.session.title,
            style: titleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildLevelChip(ThemeData theme) {
    return new Chip(
      avatar: new CircleAvatar(
        backgroundImage: LevelImage.getAssetImage(widget.session.level),
      ),
      label: new Text(
        widget.session.level.name,
        style: new TextStyle(
          color: theme.accentColor,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildHeaderContents(Size size, double t, ThemeData theme) {
    final TextStyle titleStyle = theme.textTheme.title.merge(new TextStyle(
      color: Colors.white,
    ));
    final subheadStyle = theme.textTheme.body1.merge(new TextStyle(
      color: Colors.white,
    ));
    final speakerNameStyle = theme.textTheme.subhead.merge(new TextStyle(
      color: Colors.white,
    ));

    final Curve _textOpacity =
        const Interval(0.4, 1.0, curve: Curves.easeInOut);

    return new Positioned(
      bottom: 0.0,
      width: size.width,
      child: new Opacity(
        opacity: _textOpacity.transform(t.clamp(0.0, 1.0)),
        child: new Container(
          margin: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 24.0),
          child: new Column(
            children: [
              // Title
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  widget.session.title,
                  style: titleStyle,
                ),
              ),
              // Topic
              new Container(
                margin: new EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerLeft,
                child: new Text(
                  widget.session.topic.name,
                  style: subheadStyle,
                ),
              ),
              // Level
              new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.only(top: 12.0),
                child: _buildLevelChip(theme),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 4.0),
                child: new Column(
                  children: _buildSpeakerRows(
                    widget.session.speakers,
                    speakerNameStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(double statusBarHeight, double t) {
    final Curve _textOpacity =
        const Interval(0.4, 1.0, curve: Curves.easeInOut);
    final double parallax =
        new Tween<double>(begin: _kAppBarHeight / 2.5, end: 0.0)
            .lerp(t.clamp(0.0, 1.0));

    return new Positioned(
      top: -parallax,
      left: 0.0,
      right: 0.0,
      height: _kAppBarHeight + statusBarHeight,
      child: new Opacity(
        opacity: _textOpacity.transform(t.clamp(0.0, 1.0)),
        child: new Container(
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage(
                _imgHeader,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: themeData,
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          controller: _hideFabController,
          slivers: [
            _buildAppBar(context),
            _buildBody(),
          ],
        ),
        floatingActionButton: !_isFabVisible
            ? null
            : new FloatingActionButton(
                child: new FavoriteButton(
                  session: widget.session,
                  favorite: widget.favorite,
                  googleSignIn: widget.googleSignIn,
                  onChanged: (value) {
                    widget.onFavoriteChanged(value);
                    setState(() {
                      widget.favorite = !widget.favorite;
                    });
                  },
                  activeColor: Colors.white,
                  inActiveColor: Colors.white,
                ),
                onPressed: () => {},
              ),
      ),
    );
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);
    final textStyle = theme.textTheme.body1.merge(new TextStyle(
      color: Colors.grey[600],
    ));
    final descriptionStyle = theme.textTheme.body1;

    return new SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: new SliverList(
        delegate: new SliverChildListDelegate([
          _buildDate(textStyle),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              widget.session.room.name,
              style: textStyle,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: new Text(
              widget.session.description,
              style: descriptionStyle,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildDate(TextStyle textStyle) {
    final formatter =
        new DateFormat.Hm(Localizations.localeOf(context).languageCode);
    final startAt = formatter.format(widget.session.startsAt);
    final endAt = formatter.format(widget.session.endsAt);

    return new Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: new Text(
        "${Strings.of(context).day(widget.session.getDay())} / $startAt - $endAt",
        style: textStyle,
      ),
    );
  }
}
