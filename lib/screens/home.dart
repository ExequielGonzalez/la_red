import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/size_config.dart';
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
  void initState() {
    Future.delayed(Duration.zero, () {
      SizeConfig().init(context);
      setState(() {
        kFontSize = SizeConfig.safeBlockHorizontal * 0.04;
      });
    });

    super.initState();
  }

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
                Padding(
                  padding: EdgeInsets.all(getHeight(0.01)),
                  child: Image.asset(
                    "assets/images/logo_principal.png",
                    width: getWidth(0.375),
                    height: getWidth(0.375),
                  ),
                ),
                SizedBox(
                  height: getHeight(0.016),
                ),
                Text(
                  'LA RED',
                  style: kTextStyleBold.copyWith(
                      fontSize: getWidth(0.10), height: getHeight(0.001)),
                ),
                Text(
                  'Liga de fútbol',
                  style: kTextStyleBold.copyWith(
                      fontSize: getWidth(0.046), height: getHeight(0.0015)),
                ),
                SizedBox(
                  height: getHeight(0.0065),
                ),
                SizedBox(
                  height: getHeight(0.0065),
                  width: getWidth(0.31),
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
                      padding: EdgeInsets.all(getHeight(0.005)),
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
                                onTap: () {
                                  Navigator.pushNamed(context, '/reglamento');
                                },
                              ),
                              HomeButton(
                                width: getWidth(0.38),
                                height: getHeight(0.127),
                                title: 'novedades',
                                onTap: () {
                                  Navigator.pushNamed(context, '/novedades');
                                },
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
