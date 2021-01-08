import 'package:flutter/foundation.dart';

import 'package:la_red/model/equipo.dart';

import 'package:hive/hive.dart';

import '../constants.dart';

class LeaguesProvider with ChangeNotifier {
  Leagues _leagues = Leagues.libre;

  Leagues get currentLeague => _leagues;

  void setLeague(Leagues league) {
    _leagues = league;
    notifyListeners();
  }
}
