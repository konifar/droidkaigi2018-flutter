import 'dart:async';

import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:droidkaigi2018/theme.dart';
import 'package:droidkaigi2018/ui/drawer.dart';
import 'package:droidkaigi2018/ui/map/map.dart';
import 'package:droidkaigi2018/ui/myschedule/my_schedule.dart';
import 'package:droidkaigi2018/ui/page_container.dart';
import 'package:droidkaigi2018/ui/sessions/all_sessions.dart';
import 'package:droidkaigi2018/ui/setting/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class _MyLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(_MyLocalizationsDelegate old) => false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showPerformanceOverlay = false;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) => Strings.of(context).appName,
      localizationsDelegates: [
        const _MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', ''),
      ],
      theme: themeData,
      showPerformanceOverlay: _showPerformanceOverlay,
      home: new MyHomePage(
        showPerformanceOverlay: _showPerformanceOverlay,
        onShowPerformanceOverlayChanged: (bool value) {
          setState(() => _showPerformanceOverlay = value);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  const MyHomePage({
    Key key,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
  })
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String _title = "";
  int _currentIndex = 0;
  List<PageContainer> _pages;

  List<PageContainer> _createPages() {
    return <PageContainer>[
      new PageContainer(
        title: Strings.of(context).allSessions,
        icon: new Icon(Icons.event_note),
        hasTab: true,
        body: () => new AllSessionsPage(),
        tickerProvider: this,
      ),
      new PageContainer(
        title: Strings.of(context).mySchedule,
        icon: new Icon(Icons.schedule),
        hasTab: false,
        body: () => new MySchedulePage(),
        tickerProvider: this,
      ),
      new PageContainer(
        title: Strings.of(context).access,
        icon: new Icon(Icons.map),
        hasTab: false,
        body: () => new MapPage(),
        tickerProvider: this,
      ),
      new PageContainer(
        title: Strings.of(context).settings,
        icon: new Icon(Icons.settings),
        hasTab: false,
        body: () => new SettingsPage(
              showPerformanceOverlay: widget.showPerformanceOverlay,
              onShowPerformanceOverlayChanged:
                  widget.onShowPerformanceOverlayChanged,
            ),
        tickerProvider: this,
      ),
    ];
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (PageContainer container in _pages) {
      transitions.add(container.transition());
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.listenable;
      final Animation<double> bAnimation = b.listenable;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    _pages = _createPages();

//    for (PageContainer container in _pages) {
//      container.controller.addListener(_rebuild);
//    }

    PageContainer _page = _pages[_currentIndex];
    _page.controller.value = 1.0;
    _title = _page.title;

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(_title),
        elevation: _page.hasTab ? 0.0 : 4.0,
      ),
      drawer: new MyDrawer(
        items: _pages,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _page.controller.reverse();
            _currentIndex = index;
            _page.controller.forward();
            _title = _page.title;
          });
        },
      ),
      body: new Center(
        child: _buildTransitionsStack(),
      ),
    );
  }
}
