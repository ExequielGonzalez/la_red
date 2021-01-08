import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/screens/detalles_equipo.dart';
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

  Leagues _leagues = Leagues.libre;
  List<EquiposListItem> _teamList = [];

  List<Widget> createTeamList() {
    print('entra aca');

    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;

    EquiposListItem listItem;

    print(equipos.length);
    equipos.forEach((element) {
      print('creando un nuevo listItem con ${element.nombre} y ${element.id}');
      listItem = EquiposListItem(
        equipo: element,
        onTap: () {
          detalleEquipo(element);
        },
      );

      _teamList.add(listItem);
    });
    _teamList.forEach((element) {
      print('listItem con ${element.equipo.nombre} y ${element.equipo.id}');
    });

    // print(_teamListAux.length);

    return _teamList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createTeam();
    print(Equipo.counter);
    // readTeams();
    // deleteTeams();
    // createTeamList();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<EquipoData>(context, listen: false).readTeams();
    return Scaffold(
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
                        selected: _leagues == Leagues.libre,
                        onTap: () {
                          setState(() {
                            _leagues = Leagues.libre;
                          });
                        }),
                    LeaguesTab(
                      text: 'm30',
                      width: getWidth(1),
                      selected: _leagues == Leagues.m30,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.m30;
                        });
                      },
                    ),
                    LeaguesTab(
                      text: 'm40',
                      width: getWidth(1),
                      selected: _leagues == Leagues.m40,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.m40;
                        });
                      },
                    ),
                    LeaguesTab(
                      text: 'femenino',
                      width: getWidth(1),
                      selected: _leagues == Leagues.femenino,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.femenino;
                        });
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
                      children: createTeamList() ??
                          [Center(child: CircularProgressIndicator())],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
