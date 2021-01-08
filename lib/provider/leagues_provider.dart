import 'package:flutter/foundation.dart';
import '../constants.dart';

class LeaguesProvider with ChangeNotifier {
  Leagues _leagues = Leagues.libre;

  Leagues get currentLeague => _leagues;

  void setLeague(Leagues league) {
    _leagues = league;
    notifyListeners();
  }
}
