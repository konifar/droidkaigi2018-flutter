import "package:dice/dice.dart";
import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/api/droidkaigi_api_impl.dart';

class ApiModule extends Module {
  @override
  configure() {
    register(DroidKaigiApi).toInstance(new DroidKaigiApiImpl());
  }
}
