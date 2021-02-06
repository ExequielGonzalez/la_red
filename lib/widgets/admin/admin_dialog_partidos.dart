import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:la_red/constants.dart';

import 'package:la_red/model/partido.dart';
import 'package:la_red/provider/equipo_data.dart';

import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/provider/partido_data.dart';

import 'package:la_red/screens/admin/admin_partidos_create.dart';
import 'package:la_red/screens/admin/admin_partidos_edit.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:provider/provider.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminDialogPartidos extends StatefulWidget {
  @override
  _AdminDialogPartidosState createState() => _AdminDialogPartidosState();
}

class _AdminDialogPartidosState extends State<AdminDialogPartidos> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  bool _matchesFinished = false;

  @override
  Widget build(BuildContext context) {
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    final partidosProvider = Provider.of<PartidoData>(context);
    // final partidos = partidosProvider.getPartidos;
    return ValueListenableBuilder(
        valueListenable: Hive.box<Partido>(kBoxPartidos).listenable(),
        builder: (context, _, widget) {
          return AlertDialog(
            title: Text('Lista de Partidos'),
            content: Container(
              height: getHeight(0.9), // Change as per your requirement
              width: getWidth(0.9), // Change as per your requirement
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(getWidth(0.01)),
                    child: Container(
                      height: getHeight(0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_matchesFinished ? 'Finalizados' : 'Por jugar'),
                          CupertinoSwitch(
                            activeColor: kBordo,
                            value: _matchesFinished,
                            onChanged: (value) {
                              setState(() {
                                _matchesFinished = value;
                              });
                            },
                          ),
                        ],
                      ),
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
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: _createMatchesList(
                          context, league.currentLeague, _matchesFinished),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Crear Nuevo partido",
                  style: TextStyle(color: kBordo),
                ),
                onPressed: () async {
                  //Creando un nuevo jugador
                  print('Creando un nuevo partido');
                  bool newValue = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AdminPartidosCreate();
                    }),
                  );
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

List<Widget> _createMatchesList(context, Leagues league, gamesFinished) {
  List<InkWell> _partidosList = [];
  final partidosProvider = Provider.of<PartidoData>(context);
  final equiposProvider = Provider.of<EquipoData>(context);
  final partidos = partidosProvider.getPartidos;
  // goleadores.sort();
  InkWell _listItem;

  print(partidos.toString());
  partidos.forEach((element) {
    print(element.toString());
    if (element.liga == league.toString() &&
        element.isFinished == gamesFinished) {
      print(
          'el partido entre ${element.equipo1.first.nombre} vs ${element.equipo2.first.nombre} es mostrado');

      _listItem = InkWell(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 5),
          child: Container(
            color: Colors.grey.shade50,
            child: Text(
              '${element.equipo1.first.nombre} vs ${element.equipo2.first.nombre}',
              style: kTextStyle.copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        onTap: () async {
          bool success = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPartidosEdit(
                partido: element,
              ),
            ),
          );
          // if (success) {
          //   Partido aux;
          //   aux =
          //       partidosProvider.getMatchByKey(partidosProvider.lastKeyEdited);
          //
          //   equiposProvider.editTeam(aux.equipo1.first);
          //   equiposProvider.editTeam(aux.equipo2.first);
          //   // aux.equipo1.first.save();
          //   // aux.equipo2.first.save();
          // }
        },
        onLongPress: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            child: AlertDialog(
              content: Text(
                "¿Deseas eliminar el partido entre ${element.equipo1.first.nombre} vs ${element.equipo2.first.nombre}?",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    partidosProvider.deleteMatch(element);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );

      _partidosList.add(_listItem);
    }
  });
  return _partidosList;
}
