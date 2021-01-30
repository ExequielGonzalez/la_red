import 'package:flutter/foundation.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:provider/provider.dart';

class JugadoresEquipo with ChangeNotifier {
  List<Jugador> _jugadorEquipo = [];

  List<Jugador> get jugadorEquipo => _jugadorEquipo;

  void addJugador(Jugador jugador) {
    _jugadorEquipo.add(jugador);
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
  }
}
