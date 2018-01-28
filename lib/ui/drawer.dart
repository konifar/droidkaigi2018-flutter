import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:droidkaigi2018/ui/page_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const String _defaultAccountIcon = 'assets/ic_speaker_placeholder.png';
const String _defaultAccountBackground = 'assets/img_drawer_header.png';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    @required this.items,
    this.onTap,
    this.currentIndex: 0,
    this.accountIconUrl,
    this.accountName,
    this.accountEmail,
  })
      : super() {
    assert(items != null);
    assert(0 <= currentIndex && currentIndex < items.length);
  }

  final List<PageContainer> items;

  final int currentIndex;

  final ValueChanged<int> onTap;

  final String accountIconUrl;

  final String accountName;

  final String accountEmail;

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      PageContainer container = items[i];
      lists.add(
        new ListTile(
            leading: container.icon,
            title: new Text(container.title),
            selected: currentIndex == i,
            onTap: () {
              Navigator.of(context).pop(); // Hide drawer
              if (onTap != null) onTap(i);
            }),
      );
    }

    return new Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              accountName != null ? accountName : Strings.of(context).appName,
            ),
            accountEmail: new Text(
              accountEmail != null ? accountEmail : Strings.of(context).appName,
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(
                  _defaultAccountBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          new MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new Expanded(
              child: new ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: lists,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
