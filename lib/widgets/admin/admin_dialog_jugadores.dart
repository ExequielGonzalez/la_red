import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:la_red/constants.dart';
import 'package:la_red/model/jugador.dart';

import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/screens/admin/admin_jugadores.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:provider/provider.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminDialogJugadores extends StatefulWidget {
  @override
  _AdminDialogJugadoresState createState() => _AdminDialogJugadoresState();
}

class _AdminDialogJugadoresState extends State<AdminDialogJugadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  bool _playersWithTeams = false;

  @override
  Widget build(BuildContext context) {
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    return ValueListenableBuilder(
        valueListenable: Hive.box<Jugador>(kBoxJugadores).listenable(),
        builder: (context, _, widget) {
          return AlertDialog(
            title: Text('Lista de jugadores'),
            content: Container(
              height: getHeight(0.9), // Change as per your requirement
              width: getWidth(0.9), // Change as per your requirement
              child: Column(
                children: [
                  Container(
                    height: getHeight(0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_playersWithTeams
                            ? 'Jugadores con Equipo'
                            : 'Jugadores sin Equipo'),
                        CupertinoSwitch(
                          activeColor: kBordo,
                          value: _playersWithTeams,
                          onChanged: (value) {
                            setState(() {
                              _playersWithTeams = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: kBordo,
                    height: getHeight(0.04),
                    child: Row(
                      children: [
                        LeaguesTab(
                            text: 'libre',
                            width: getWidth(1),
                            selected: league.currentLeague == Leagues.libre,
                            onTap: () {
                              league.setLeague(Leagues.libre);
                            }),
                        LeaguesTab(
                          text: 'm30',
                          width: getWidth(1),
                          selected: league.currentLeague == Leagues.m30,
                          onTap: () {
                            league.setLeague(Leagues.m30);
                          },
                        ),
                        LeaguesTab(
                          text: 'm40',
                          width: getWidth(1),
                          selected: league.currentLeague == Leagues.m40,
                          onTap: () {
                            league.setLeague(Leagues.m40);
                          },
                        ),
                        LeaguesTab(
                          text: 'fem',
                          width: getWidth(1),
                          selected: league.currentLeague == Leagues.femenino,
                          onTap: () {
                            league.setLeague(Leagues.femenino);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: _createPlayerList(
                          context, league.currentLeague, _playersWithTeams),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Crear Nuevo jugador",
                  style: TextStyle(color: kBordo),
                ),
                onPressed: () async {
                  //Creando un nuevo jugador
                  print('Creando un nuevo jugador');
                  bool newValue = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AdminJugadores();
                    }),
                  );
                  // if (newValue) {
                  //   // print('${aux.toString()} fue creado');
                  //   setState(() {});
                  // }
                  // jugadores.editPlayer(aux);
                },
              ),
              FlatButton(
                child: Text(
                  "Salir",
                  style: TextStyle(color: kBordo),
                ),
                onPressed: () {
//Put your code here which you want to execute on Cancel button click.

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

List<Widget> _createPlayerList(context, Leagues league, playersWithTeam) {
  List<InkWell> _jugadoresList = [];
  final jugadoresProvdier = Provider.of<JugadorData>(context, listen: false);
  final jugadores = jugadoresProvdier.getJugadores;
  // goleadores.sort();
  InkWell _listItem;

  print(jugadores.toString());
  jugadores.forEach((element) {
    print(element.toString());
    if (element.liga == league.toString() &&
        element.hasTeam == playersWithTeam) {
      print(
          'creando un nuevo listItem con ${element.nombre} y dni: ${element.dni}');
      _listItem = InkWell(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 5),
          child: Container(
            color: Colors.grey.shade50,
            child: Text(
              '${element.nombre} ${element.apellido}',
              style: kTextStyle.copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminJugadores(
                jugador: element,
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            child: AlertDialog(
              content: Text(
                "¿Deseas eliminar a ${element.nombre} ${element.apellido}?",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    jugadoresProvdier.deletePlayer(element);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );

      _jugadoresList.add(_listItem);
    }
  });
  return _jugadoresList;
}
