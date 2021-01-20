import 'package:flutter/foundation.dart';
import 'package:la_red/model/jugador.dart';

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
}
