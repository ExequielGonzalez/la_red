import 'package:flutter/foundation.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:provider/provider.dart';

class JugadoresEquipo with ChangeNotifier {
  List<Jugador> _jugadorEquipo = [];

  List<Jugador> get jugadorEquipo => _jugadorEquipo;

  List<Jugador> _equipo1 = [];
  List<Jugador> _equipo2 = [];
  List<Jugador> get jugadoresEquipo1 => _equipo1;
  List<Jugador> get jugadoresEquipo2 => _equipo2;

  void addJugador(Jugador jugador) {
    _jugadorEquipo.add(jugador);
    notifyListeners();
  }

  void addJugadorEquipo1(Jugador jugador) {
    bool isInTeam = false;
    _equipo1.forEach((element) {
      if (element.dni == jugador.dni) {
        element = jugador;
        isInTeam = true;
      }
    });
    if (!isInTeam) _equipo1.add(jugador);
    notifyListeners();
  }

  void addJugadorEquipo2(Jugador jugador) {
    bool isInTeam = false;
    _equipo2.forEach((element) {
      if (element.dni == jugador.dni) {
        element = jugador;
        isInTeam = true;
      }
    });
    if (!isInTeam) _equipo2.add(jugador);

    notifyListeners();
  }

  void addJugadores(List<Jugador> jugadores) {
    _jugadorEquipo.addAll(jugadores);
    notifyListeners();
  }

  void deleteJugador(context, Jugador jugador) {
    jugador.hasTeam = false;
    Provider.of<JugadorData>(context, listen: false).editPlayer(jugador);
    _jugadorEquipo.removeWhere((element) => element.dni == jugador.dni);
    notifyListeners();
  }

  void clearList() {
    _jugadorEquipo.clear();
    _equipo1.clear();
    _equipo2.clear();
  }
}
