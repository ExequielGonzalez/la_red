import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/fixtureListItem.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/model/equipo.dart';

class DetallesEquipo extends StatefulWidget {
  final Equipo equipo;

  DetallesEquipo(this.equipo);

  @override
  _DetallesEquipoState createState() => _DetallesEquipoState();
}

class _DetallesEquipoState extends State<DetallesEquipo> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.equipo);
  }

  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  void updateUI(Equipo equipo) {
    setState(() {
      if (equipo == null)
        title = 'nada';
      else {
        title = equipo.nombre;
      }
    });
  }

  String title;
  double scale = 0.045;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                ScreenBanner(
                  height: getHeight(1),
                  width: getWidth(1),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBordo,
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: getHeight(0.08),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(0.02),
                                vertical: getHeight(0.004),
                              ),
                              child: Container(
                                width: getWidth(0.15),
                                height: getWidth(0.15),
//
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.memory(widget.equipo.photoURL),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight(0.01),
                                      horizontal: getWidth(0.02)),
                                  child: Container(
                                    height: getHeight(0.08),
                                    child: Center(
                                      child: Text(
                                        title,
                                        style: kTextStyleBold.copyWith(
                                            fontSize: getWidth(0.07),
                                            height: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: getHeight(0.029),
                                ),
                                height: getHeight(0.16), //
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(0.05),
                                        ),
                                        child: Text(
                                          'PRÓXIMO PARTIDO',
                                          style: kTextStyleBold.copyWith(
                                              color: kBordo,
                                              fontSize: kFontSize),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: getHeight(0.02),
                                    // ),
                                    Center(
                                      child: Container(
                                        height: getHeight(0.1), //

                                        decoration: BoxDecoration(
                                          color: kBordo,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        // child: FixtureListItem(
                                        //   height: getHeight(1),
                                        //   width: getWidth(1),
                                        //   equipo1: 'Barcelona',
                                        //   equipo2: 'Real Madrid',
                                        //   fecha: 'MIERCOLES 28/11',
                                        //   hora: '17:30',
                                        //   numCancha: 1,
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: getHeight(0.029),
                                ),
                                height: getHeight(0.16), //
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(0.05),
                                        ),
                                        child: Text(
                                          'ÚLTIMO PARTIDO',
                                          style: kTextStyleBold.copyWith(
                                              color: kBordo,
                                              fontSize: kFontSize),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: getHeight(0.1), //
                                        decoration: BoxDecoration(
                                          color: kBordo,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: getWidth(0.05),
                                                    vertical: getHeight(0.002),
                                                  ),
                                                  child: Container(
                                                    width: getWidth(0.07),
                                                    height: getWidth(0.07),
//
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      child: Image.asset(
                                                          "assets/images/fixture.png"),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: getWidth(0.05),
                                                    vertical: getHeight(0.002),
                                                  ),
                                                  child: Container(
                                                    width: getWidth(0.07),
                                                    height: getWidth(0.07),
//
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      child: Image.asset(
                                                          "assets/images/fixture.png"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 3,
                                                    child: Text(
                                                      'Arsenal',
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize:
                                                                  kFontSize),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getHeight(0.01),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: Text(
                                                      'Real Madrid',
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize:
                                                                  kFontSize),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: getWidth(0.04)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: getWidth(0.35),
                                                    child: Center(
                                                      child: Text(
                                                        '1',
                                                        style:
                                                            kTextStyle.copyWith(
                                                                fontSize:
                                                                    kFontSize),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getHeight(0.01),
                                                  ),
                                                  Container(
                                                    width: getWidth(0.35),
                                                    child: Center(
                                                      child: Text(
                                                        '2',
                                                        style:
                                                            kTextStyle.copyWith(
                                                                fontSize:
                                                                    kFontSize),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
