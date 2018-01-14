import "package:dice/dice.dart";
import 'package:droidkaigi2018/di/api_module.dart';
import 'package:droidkaigi2018/di/repository_module.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';

main() async {

  SessionRepository repository = new

  var sessions = await repository.findAll();

  for (var session in sessions.values) {
    print(session.title);
  }
}
