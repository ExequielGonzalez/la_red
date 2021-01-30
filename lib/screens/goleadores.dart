import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/widgets/admin/admin_fab.dart';

import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/goleadores_list_item.dart';
import 'package:la_red/widgets/leagues_tab.dart';

import 'package:provider/provider.dart';

import '../constants.dart';

import 'dart:developer' as dev;

class Goleadores extends StatefulWidget {
  @override
  _GoleadoresState createState() => _GoleadoresState();
}

class _GoleadoresState extends State<Goleadores> {
  //TODO: El problema de que la id me cambie esta en esta clase
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  double scale = 0.045;

  List<GoleadoresListItem> _goleadoresList = [];

  List<Widget> createPlayerList(Leagues league) {
    _goleadoresList = [];
    List<Jugador> goleadores =
        Provider.of<JugadorData>(context, listen: false).getJugadores;

    goleadores = goleadores
        .where(
            (element) => element.liga == league.toString() && element.goles > 0)
        .toList();

    Comparator<Jugador> sortByGoles = (b, a) => a.goles.compareTo(b.goles);
    goleadores.sort(sortByGoles);
    GoleadoresListItem _listItem;

    int lengthItemsList = goleadores.length <= 10 ? goleadores.length : 10;

    for (int _posicion = 1; _posicion <= lengthItemsList; _posicion++) {
      print(_posicion);
      print(
          'Goleadores tab:creando un nuevo listItem con ${goleadores[_posicion - 1].nombre} y dni: ${goleadores[_posicion - 1].dni} y la id ${goleadores[_posicion - 1].id}');

      _listItem = GoleadoresListItem(
        jugador: goleadores[_posicion - 1],
        posicion: _posicion,
      );

      _goleadoresList.add(_listItem);
    }
    return _goleadoresList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   Provider.of<JugadorData>(context, listen: false).createPlayer();
    // });
  }

  @override
  Widget build(BuildContext context) {
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    return Scaffold(
      floatingActionButton: kAdmin ? AdminFAB() : Container(),
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'goleadores',
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: getHeight(0.067),
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
                      text: 'femenino',
                      width: getWidth(1),
                      selected: league.currentLeague == Leagues.femenino,
                      onTap: () {
                        league.setLeague(Leagues.femenino);
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: getHeight(0.005)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth(0.015)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //nombre y goles
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(0.11)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'NOMBRE',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(0.05)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'GOLES',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<Jugador>(kBoxJugadores).listenable(),
                            builder: (context, _, widget) {
                              return ListView(
                                padding:
                                    EdgeInsets.only(bottom: getHeight(0.01)),
                                children: createPlayerList(
                                        league.currentLeague) ??
                                    [
                                      Center(child: CircularProgressIndicator())
                                    ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
