import 'package:droidkaigi2018/repository/repository_factory.dart';

main() async {
  var sessions = await new RepositoryFactory().getSessionRepository().findAll();
  for (var session in sessions) {
    print(session.title);
  }
}
