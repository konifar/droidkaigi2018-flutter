import 'dart:io';

import 'package:droidkaigi2018/i18n/strings.dart';
import 'package:droidkaigi2018/ui/map/marker.dart';
import 'package:droidkaigi2018/ui/map/static_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String _icPlace = 'assets/ic_place_orange_24.png';
const String _icTrain = 'assets/ic_train_orange_24.png';
const String _icGoogleMap = 'assets/ic_googlemap.png';

const _staticMapApiKey = "AIzaSyBM9V5LdnczVfAC9v6tbG0QanV8tE5lq48";
const _lat = 35.6957954;
const _lang = 139.69038920000003;

const _placeUrl = 'https://www.google.com/maps?q=$_lat,$_lang';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String apiKey = Platform.environment['STATIC_MAP_API_KEY'];
    if (apiKey == null) apiKey = _staticMapApiKey;

    ThemeData theme = Theme.of(context);
    final Marker _marker =
        new Marker("place", "", _lat, _lang, color: theme.accentColor);

    final TextStyle titleStyle =
        theme.textTheme.title.merge(new TextStyle(color: Colors.white));
    final TextStyle descriptionStyle =
        theme.textTheme.body1.merge(new TextStyle(color: Colors.white));

    var staticMapProvider = new StaticMapProvider(apiKey);
    Uri staticMapUri = staticMapProvider
        .getStaticUriWithMarkers([_marker], 14, width: 900, height: 450);

    return new SingleChildScrollView(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Stack(
            children: [
              new Container(
                child: new Image.network(staticMapUri.toString()),
              ),
              new Positioned(
                bottom: 16.0,
                right: 16.0,
                child: new InkWell(
                  onTap: _launchMap,
                  child: new Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 36.0,
                    height: 36.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.circular(4.0),
                      image: new DecorationImage(
                        image: new AssetImage(_icGoogleMap),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            color: theme.primaryColor,
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: [
                new Container(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    Strings.of(context).mapPlaceName,
                    style: titleStyle,
                  ),
                ),
                new Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                    Strings.of(context).mapMeetingRoomsName,
                    style: descriptionStyle,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: new Row(
              children: [
                _buildIcon(_icPlace),
                new Expanded(
                  child: new Text(
                    Strings.of(context).mapAddress,
                    style: theme.textTheme.body1,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 24.0, right: 16.0, bottom: 16.0),
            child: new Row(
              children: [
                _buildIcon(_icTrain),
                new Expanded(
                  child: new Text(
                    Strings.of(context).mapNearbyStations,
                    style: theme.textTheme.body1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String iconFile) {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      width: 24.0,
      height: 24.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(iconFile),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _launchMap() async {
    if (await canLaunch(_placeUrl)) {
      await launch(_placeUrl);
    } else {
      throw 'Could not launch $_placeUrl';
    }
  }
}
