import 'package:droidkaigi2018/api/droidkaigi_api.dart';
import 'package:droidkaigi2018/api/droidkaigi_api_impl.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';
import 'package:droidkaigi2018/repository/session_repository_impl.dart';

main() async {
  DroidKaigiApi api = new DroidKaigiApiImpl();
  SessionRepository repository = new SessionRepositoryImpl(api, new Map());

  var sessions = await repository.findAll();

  for (var session in sessions.values) {
    print(session.title);
  }
}
