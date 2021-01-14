import 'package:flutter/foundation.dart';
import '../constants.dart';

class LeaguesProvider with ChangeNotifier {
  Leagues _leagues = Leagues.libre;

  Leagues get currentLeague => _leagues;
  String get currentLeagueString => _leagues.toString();

  void setLeague(Leagues league) {
    _leagues = league;
    notifyListeners();
  }

  void setLeagueString(String league) {
    switch (league) {
      case 'libre':
        setLeague(Leagues.libre);
        break;
      case 'm30':
        setLeague(Leagues.m30);
        break;
      case 'm40':
        setLeague(Leagues.m40);
        break;
      case 'femenino':
        setLeague(Leagues.femenino);
        break;
    }
  }
}
