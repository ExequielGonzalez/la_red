import 'package:flutter/material.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/screens/detalles_equipo.dart';
import 'package:la_red/widgets/admin/admin_fab.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/equiposListItem.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Equipos extends StatefulWidget {
  @override
  _EquiposState createState() => _EquiposState();
}

class _EquiposState extends State<Equipos> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  void detalleEquipo(Equipo equipo) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetallesEquipo(equipo)));
  }

  List<EquiposListItem> _teamList = [];

  List<Widget> createTeamList(Leagues league) {
    _teamList = [];
    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;

    EquiposListItem _listItem;

    print(equipos.length);
    equipos.forEach((element) {
      if (element.liga == league.toString()) {
        print(
            'creando un nuevo listItem con ${element.nombre}, ${element.id} y con jugadores: ${element.jugadores.toString()} y con los partidos previos: ${element.partidosAnteriores}');
        _listItem = EquiposListItem(
          equipo: element,
          onTap: () {
            detalleEquipo(element);
          },
        );

        _teamList.add(_listItem);
      }
    });
    // _teamList.forEach((element) {
    //   print('listItem con ${element.equipo.nombre} y ${element.equipo.id}');
    // });

    // print(_teamListAux.length);

    return _teamList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   Provider.of<EquipoData>(context, listen: false).createTeam();
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
        title: 'equipos',
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  margin: EdgeInsets.only(
                      left: getWidth(0.076),
                      right: getWidth(0.076),
                      top: getHeight(0.029),
                      bottom: 0),
//
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),

                  child: ListView(
                    padding: EdgeInsets.only(bottom: getHeight(0.01)),
                    children: createTeamList(league.currentLeague) ??
                        [Center(child: CircularProgressIndicator())],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
