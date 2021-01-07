import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/screens/detalles_equipo.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/equiposListItem.dart';
import 'package:la_red/widgets/leagues_tab.dart';

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
  List<Equipo> _equipos = [];
  List<EquiposListItem> _teamList = [];

  void createTeam() async {
    var box = await Hive.openBox('Equipos');

    Equipo.counter = box.get('size', defaultValue: 0);
    print(Equipo.counter);
    box.put('eq${Equipo.counter}', Equipo.auto());
    box.put('size', Equipo.counter);
    box.put('eq${Equipo.counter}', Equipo.auto());
    box.put('size', Equipo.counter);
  }

  void readTeams() async {
    var box = await Hive.openBox('Equipos');
    Equipo.counter = box.get('size', defaultValue: 0);
    for (int i = 0; i < Equipo.counter; i++) {
      var aux = await box.get('eq$i');
      _equipos.add(aux);
    }
    _equipos.forEach((element) {
      print(element.id);
      print(element.nombre);
    });
    await Future.delayed(Duration(seconds: 1), () {
      print("1 sec later");
    });
  }

  void deleteTeams() async {
    var box = await Hive.openBox('Equipos');
    box.deleteFromDisk();
  }

  void closeDB() async {
    var box = await Hive.openBox('Equipos');
    box.put('size', Equipo.counter);
  }

  List<Widget> createTeamList() {
    EquiposListItem listItem;

    print(_equipos.length);
    _equipos.forEach((element) {
      print('creando un nuevo listItem con ${element.nombre} y ${element.id}');
      listItem = EquiposListItem(
        equipo: element,
        onTap: () {
          detalleEquipo(element);
        },
      );
      setState(() {
        _teamList.add(listItem);
      });
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
    readTeams();
    // deleteTeams();
    // createTeamList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    closeDB();
  }

  @override
  Widget build(BuildContext context) {
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
