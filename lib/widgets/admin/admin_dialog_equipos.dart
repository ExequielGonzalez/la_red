import 'package:flutter/material.dart';

import 'package:la_red/constants.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/provider/equipo_data.dart';

import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/screens/admin/admin_equipos.dart';

import 'package:la_red/widgets/leagues_tab.dart';
import 'package:provider/provider.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminDialogEquipos extends StatefulWidget {
  @override
  _AdminDialogEquiposState createState() => _AdminDialogEquiposState();
}

class _AdminDialogEquiposState extends State<AdminDialogEquipos> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    // final equipos = Provider.of<JugadorData>(context, listen: false);
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    return ValueListenableBuilder(
        valueListenable: Hive.box<Equipo>(kBoxEquipos).listenable(),
        builder: (context, _, widget) {
          return AlertDialog(
            title: Text('Lista de equipos'),
            content: Container(
              height: getHeight(0.9), // Change as per your requirement
              width: getWidth(0.9), // Change as per your requirement
              child: Column(
                children: [
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
                      children: _createTeamList(context, league.currentLeague),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Crear Nuevo Equipo",
                  style: TextStyle(color: kBordo),
                ),
                onPressed: () async {
                  //Creando un nuevo jugador
                  print('Creando un nuevo equipo');
                  bool newValue = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AdminEquipos();
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

List<Widget> _createTeamList(context, Leagues league) {
  List<InkWell> _equiposList = [];
  final equiposProvider = Provider.of<EquipoData>(context, listen: false);
  final equipos = equiposProvider.getEquipos;

  InkWell _listItem;

  print(equipos.toString());
  equipos.forEach((element) {
    print(element.toString());
    if (element.liga == league.toString()) {
      print('creando un nuevo listItem con ${element.nombre} ');
      _listItem = InkWell(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 5),
          child: Container(
            color: Colors.grey.shade50,
            child: Text(
              '${element.nombre} ',
              style: kTextStyle.copyWith(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminEquipos(
                equipo: element,
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
                "¿Deseas eliminar a ${element.nombre} ?",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    element.jugadores.forEach((element) {
                      element.hasTeam = false;
                      element.save();
                    });
                    equiposProvider.deleteTeam(element);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );

      _equiposList.add(_listItem);
    }
  });
  return _equiposList;
}
