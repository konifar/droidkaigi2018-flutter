import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({
    Key key,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
  })
      : super(key: key);

  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return new ListView(
      children: [
        new CheckboxListTile(
          title: new Text(Strings.of(context).settingsShowPerformanceOverlay),
          value: showPerformanceOverlay,
          onChanged: onShowPerformanceOverlayChanged,
          secondary: new Icon(
            Icons.assessment,
            color: theme.accentColor,
          ),
          selected: showPerformanceOverlay,
        ),
      ],
    );
  }
}
