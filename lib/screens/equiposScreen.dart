import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/equiposListItem.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

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

  Leagues _leagues = Leagues.libre;

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
                    children: [
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'primero',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'Real Madrid F.C asdsa',
                      ),
                      EquiposListItem(
                        height: getHeight(1),
                        width: getWidth(1),
                        nombre: 'ultimo',
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
  }
}
