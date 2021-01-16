import 'package:flutter/material.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/widgets/admin/admin_fab.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/goleadores_list_item.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Goleadores extends StatefulWidget {
  @override
  _GoleadoresState createState() => _GoleadoresState();
}

class _GoleadoresState extends State<Goleadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  double scale = 0.045;

  List<GoleadoresListItem> _goleadoresList = [];

  List<Widget> createPlayerList(Leagues league) {
    _goleadoresList = [];
    final goleadores =
        Provider.of<JugadorData>(context, listen: false).getJugadores;
    goleadores.sort();
    GoleadoresListItem _listItem;

    print(goleadores.toString());
    goleadores.forEach((element) {
      print(element.nombre);
      print(element.liga);
      if (element.liga == league.toString()) {
        print(
            'creando un nuevo listItem con ${element.nombre} y dni: ${element.dni}');
        _listItem = GoleadoresListItem(
          jugador: element,
        );

        _goleadoresList.add(_listItem);
      }
    });
    // _teamList.forEach((element) {
    //   print('listItem con ${element.equipo.nombre} y ${element.equipo.id}');
    // });

    // print(_teamListAux.length);

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
                        child: ListView(
                          padding: EdgeInsets.only(bottom: getHeight(0.01)),
                          children: createPlayerList(league.currentLeague) ??
                              [Center(child: CircularProgressIndicator())],
                        ),
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
