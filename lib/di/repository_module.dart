import "package:dice/dice.dart";
import 'package:droidkaigi2018/repository/session_repository.dart';
import 'package:droidkaigi2018/repository/session_repository_impl.dart';

class RepositoryModule extends Module {
  @override
  configure() {
    register(SessionRepository).toInstance(new SessionRepositoryImpl());
  }
}
