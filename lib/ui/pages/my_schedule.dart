import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:flutter/material.dart';

class MySchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text(Strings.of(context).mySchedule);
  }
}
