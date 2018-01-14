import 'package:droidkaigi2018/api/droidkaigi_api_impl.dart';

main() async {
  var sessions = await new DroidKaigiApiImpl().getSessions();

  for (var session in sessions.values) {
    print(session.title);
  }
}
