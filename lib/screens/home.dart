import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/home_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(0.053),
                ),
                Image.asset(
                  "assets/images/logo_principal.png",
                  width: getWidth(0.375),
                  height: getWidth(0.375),
                ),
                SizedBox(
                  height: getHeight(0.016),
                ),
                Text(
                  'LA RED',
                  style: kTextStyleBold.copyWith(fontSize: 56, height: 1),
                ),
                Text(
                  'Liga de fútbol',
                  style: kTextStyle.copyWith(fontSize: 26, height: 1),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                  width: 140,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: getHeight(0.016),
                ),
                Container(
                    width: getWidth(0.85),
                    height: getHeight(0.57),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'equipos',
                                onTap: () {
                                  Navigator.pushNamed(context, '/equipos');
                                },
                              ),
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'fixture',
                                onTap: () {
                                  Navigator.pushNamed(context, '/fixture');
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'posiciones',
                                onTap: () {
                                  Navigator.pushNamed(context, '/posiciones');
                                },
                              ),
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'goleadores',
                                onTap: () {
                                  Navigator.pushNamed(context, '/goleadores');
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'instalaciones',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/instalaciones');
                                },
                              ),
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'contacto',
                                onTap: () {
                                  Navigator.pushNamed(context, '/contacto');
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'reglamento',
                              ),
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'novedades',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
//
            ),
          ),
        ],
      ),
    );
  }
}
