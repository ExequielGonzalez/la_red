import 'package:flutter/foundation.dart';
import '../constants.dart';

class LeaguesProvider with ChangeNotifier {
  Leagues _leagues = Leagues.libre;

  Leagues get currentLeague => _leagues;

  String get currentLeagueString {
    switch (currentLeague) {
      case Leagues.libre:
        return 'libre';
        break;
      case Leagues.m30:
        return 'm30';
        break;
      case Leagues.m40:
        return 'm40';
        break;
      case Leagues.femenino:
        return 'femenino';
        break;
    }
  }

  List<String> get leagues {
    List<String> aux = [];
    aux.add('libre');
    aux.add('m30');
    aux.add('m40');
    aux.add('femenino');
    return aux;
  }

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
