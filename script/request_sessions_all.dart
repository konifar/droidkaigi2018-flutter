import "package:dice/dice.dart";
import 'package:droidkaigi2018/di/api_module.dart';
import 'package:droidkaigi2018/di/repository_module.dart';
import 'package:droidkaigi2018/repository/session_repository.dart';

main() async {
  var injector =
      new Injector.fromModules([new ApiModule(), new RepositoryModule()]);

  SessionRepository repository = injector.getInstance(SessionRepository);

  var sessions = await repository.findAll();

  for (var session in sessions.values) {
    print(session.title);
  }
}
