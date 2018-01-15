import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:flutter/material.dart';

class AllSessionsPage extends StatefulWidget {
  @override
  State createState() => new AllSessionsPageState();
}

class AllSessionsPageState extends State<AllSessionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Text(Strings.of(context).allSessions);
  }
}
