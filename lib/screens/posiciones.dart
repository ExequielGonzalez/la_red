import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Posiciones extends StatefulWidget {
  @override
  _FixtureState createState() => _FixtureState();
}

class _FixtureState extends State<Posiciones> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  Leagues _leagues = Leagues.libre;

  double scale = 0.05;
  double gridPadding = 2.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'posiciones',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'PTS',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'J',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'G',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'E',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'P',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'GF',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Text(
                                'GE',
                                style: kTextStyleBold.copyWith(
                                    color: kBordo, fontSize: getWidth(scale)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: getHeight(0.01)),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(0.004),
                                vertical: getHeight(0.001),
                              ),
                              child: Container(
                                width: getWidth(0.08),
                                height: getHeight(0.05),
//
                                decoration: BoxDecoration(
                                  color: kBordo,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        '1',
                                        style:
                                            kTextStyle.copyWith(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      width: getWidth(0.08),
                                      height: getWidth(0.08),
//
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Image.asset(
                                            "assets/images/fixture.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Expanded(
                                        //Revisar!!!!
                                        child: Text(
                                          'Real Madrid C.F',
                                          style:
                                              kTextStyle.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
