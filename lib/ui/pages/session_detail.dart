import 'package:droidkaigi2018/models/session.dart';
import 'package:droidkaigi2018/models/speaker.dart';
import 'package:droidkaigi2018/theme.dart';
import 'package:flutter/material.dart';

class SessionDetail extends StatefulWidget {
  final Session _session;

  SessionDetail(this._session);

  @override
  _SessionDetailState createState() => new _SessionDetailState();
}

const double _kAppBarHeight = 320.0;
const String _icNiche = 'assets/ic_niche_cyan_20.png';
const String _icSenior = 'assets/ic_intermediate_senior_bluegray_20.png';
const String _icBeginner = 'assets/ic_beginner_lightgreen_20.png';

const String _defaultAccountBackground = 'assets/img_drawer_header.png';

enum AppBarBehavior { normal, pinned, floating, snapping }

class _SessionDetailState extends State<SessionDetail> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  double _decideFontSize(double titleWidth) {
    double fontSize = titleWidth / widget._session.title.length;
    if (fontSize < 10.0) {
      fontSize = fontSize * 2;
    }
    if (fontSize > 18.0) {
      fontSize = 18.0;
    } else if (fontSize < 9.0) {
      fontSize = 9.0;
    }
    return fontSize;
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.title.merge(new TextStyle(
      color: Colors.white,
    ));
    final subheadStyle =
        theme.textTheme.caption.merge(new TextStyle(color: Colors.white));
    final speakerNameStyle =
        theme.textTheme.body2.merge(new TextStyle(color: Colors.white));

    final Curve _textOpacity =
        const Interval(0.4, 1.0, curve: Curves.easeInOut);
    final Size screenSize = MediaQuery.of(context).size;
    final double titleWidth =
        screenSize.width - kToolbarHeight - NavigationToolbar.kMiddleSpacing;

    List<Widget> _createSpeakerRows(
        List<Speaker> speakers, TextStyle speakerNameStyle) {
      return speakers.map((speaker) {
        int index = speakers.indexOf(speaker);
//        double paddingLeft = index == 0 ? 0.0 : 16.0;
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

    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      flexibleSpace: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = constraints.biggest;
        final double appBarHeight = size.height - statusBarHeight;
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);

        final double parallax =
            new Tween<double>(begin: _kAppBarHeight / 2.5, end: 0.0)
                .lerp(t.clamp(0.0, 1.0));

        return new Stack(
          children: [
            new Positioned(
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
                        _defaultAccountBackground,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            new Positioned(
              bottom: 0.0,
              width: size.width,
              child: new Opacity(
                opacity: _textOpacity.transform(t.clamp(0.0, 1.0)),
                child: new Container(
                  margin: const EdgeInsets.all(16.0),
                  child: new Column(
                    children: [
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          widget._session.title,
                          style: titleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top: 16.0),
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          widget._session.topic.name,
                          style: subheadStyle,
                        ),
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.only(top: 12.0),
                        child: new Chip(
                          avatar: new CircleAvatar(
                            backgroundImage: const AssetImage(_icNiche),
                          ),
                          label: new Text(
                            widget._session.level.name,
                            style: new TextStyle(
                              color: theme.accentColor,
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 4.0),
                        child: new Column(
                          children: _createSpeakerRows(
                              widget._session.speakers, speakerNameStyle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Positioned.fromRect(
              rect: new Rect.fromLTWH(
                  kToolbarHeight - NavigationToolbar.kMiddleSpacing,
                  statusBarHeight,
                  titleWidth,
                  kToolbarHeight),
              child: new Center(
                child: new Opacity(
                  opacity: _textOpacity.transform(1 - t.clamp(0.0, 1.0)),
                  child: new Text(
                    widget._session.title,
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double titleWidth = screenSize.width / 1.5 - 32.0;
    double fontSize = _decideFontSize(titleWidth);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Theme(
      data: themeData,
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: [
            _buildAppBar(context, statusBarHeight),
            new SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: new SliverToBoxAdapter(
                child: new Text(widget._session.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  Header({this.height, this.t});

  final double height;
  final double t;

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header> {
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: _textOpacity.transform(1 - widget.t),
      child: new Text(
        "まだAPI定義管理で消耗してるの？〜Swaggerを用いた大規模アプリ時代のAPI定義管理とコードジェネレート〜",
        style: new TextStyle(fontSize: 18.0),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
