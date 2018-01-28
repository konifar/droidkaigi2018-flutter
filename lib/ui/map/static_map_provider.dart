import 'package:droidkaigi2018/ui/map/Location.dart';
import 'package:droidkaigi2018/ui/map/Marker.dart';
import 'package:uri/uri.dart';

class StaticMapProvider {
  final String googleMapsApiKey;
  static const int defaultZoomLevel = 4;
  static const int defaultWidth = 600;
  static const int defaultHeight = 400;

  StaticMapProvider(this.googleMapsApiKey);

  Uri getStaticUri(Location center, int zoomLevel, {int width, int height}) {
    return _buildUrl(null, center, zoomLevel ?? defaultZoomLevel,
        width ?? defaultWidth, height ?? defaultHeight);
  }

  Uri getStaticUriWithMarkers(List<Marker> markers, int zoomLevel,
      {int width, int height}) {
    return _buildUrl(markers, null, zoomLevel, width ?? defaultWidth,
        height ?? defaultHeight);
  }

  Uri _buildUrl(List<Marker> locations, Location center, int zoomLevel,
      int width, int height) {
    var finalUri = new UriBuilder()
      ..scheme = 'https'
      ..host = 'maps.googleapis.com'
      ..port = 443
      ..path = '/maps/api/staticmap';

    if (center == null && (locations == null || locations.length == 0)) {
      center = Location.DROID_KAIGI_2018;
    }

    if (locations == null || locations.length == 0) {
      if (center == null) center = Location.DROID_KAIGI_2018;
      finalUri.queryParameters = {
        'center': '${center.latitude},${center.longitude}',
        'zoom': zoomLevel.toString(),
        'size': '${width ?? defaultWidth}x${height ?? defaultHeight}',
        'key': googleMapsApiKey,
      };
    } else {
      List<String> markers = new List();
      locations.forEach((location) {
        num lat = location.latitude;
        num lng = location.longitude;
        String marker = '$lat,$lng';
        markers.add(marker);
      });
      String markersString = markers.join('|');
      finalUri.queryParameters = {
        'markers': markersString,
        'size': '${width ?? defaultWidth}x${height ?? defaultHeight}',
        'key': googleMapsApiKey,
      };
    }

    var uri = finalUri.build();
    return uri;
  }
}
