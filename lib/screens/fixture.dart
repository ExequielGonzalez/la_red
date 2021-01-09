import 'package:flutter/material.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/equiposListItem.dart';
import 'package:la_red/widgets/fixtureListItem.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Fixture extends StatefulWidget {
  @override
  _FixtureState createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  List<FixtureListItem> _fixtureList = [];

  List<Widget> createFixtureList(Leagues league) {
    _fixtureList = [];
    final partidos =
        Provider.of<PartidoData>(context, listen: false).getPartidos;

    FixtureListItem _listItem;

    print(partidos.length);
    partidos.forEach((element) {
      if (element.liga == league.toString()) {
        print(
            'creando un nuevo partido ${element.equipo1.nombre} vs ${element.equipo2.nombre}');
        _listItem = FixtureListItem(
          partido: element,
        );

        _fixtureList.add(_listItem);
      }
    });

    return _fixtureList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   Provider.of<PartidoData>(context, listen: false).createMatchAuto();
    // });
  }

  @override
  Widget build(BuildContext context) {
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'fixture',
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
                            EdgeInsets.symmetric(horizontal: getWidth(0.05)),
                        child: Text(
                          'PARTIDOS',
                          style: kTextStyleBold.copyWith(
                              color: kBordo, fontSize: 30),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: getHeight(0.01)),
                          children: createFixtureList(league.currentLeague) ??
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
  }
}
