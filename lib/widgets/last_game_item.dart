import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/partido.dart';
import 'package:la_red/size_config.dart';

class LastGameItem extends StatelessWidget {
  Partido lastGame;
  LastGameItem({this.lastGame});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.safeBlockHorizontal;
    double height = SizeConfig.blockSizeVertical;
    return Container(
      margin: EdgeInsets.only(
        top: height * (0.029),
      ),
      height: height * (0.16), //
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * (0.05),
              ),
              child: Text(
                'ÚLTIMO PARTIDO',
                style:
                    kTextStyleBold.copyWith(color: kBordo, fontSize: kFontSize),
              ),
            ),
          ),
          Center(
            child: Container(
              height: height * (0.1), //
              decoration: BoxDecoration(
                color: kBordo,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * (0.05),
                          vertical: height * (0.002),
                        ),
                        child: Container(
                          width: width * (0.07),
                          height: width * (0.07),
//
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                                Image.memory(lastGame.equipo1.first.photoURL),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * (0.05),
                          vertical: height * (0.002),
                        ),
                        child: Container(
                          width: width * (0.07),
                          height: width * (0.07),
//
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                                Image.memory(lastGame.equipo2.first.photoURL),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            lastGame.equipo1.first.nombre,
                            style: kTextStyle.copyWith(fontSize: kFontSize),
                          ),
                        ),
                        SizedBox(
                          height: height * (0.01),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            lastGame.equipo2.first.nombre,
                            style: kTextStyle.copyWith(fontSize: kFontSize),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * (0.04)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width * (0.35),
                          child: Center(
                            child: Text(
                              lastGame.golE1.toString(),
                              style: kTextStyle.copyWith(fontSize: kFontSize),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * (0.01),
                        ),
                        Container(
                          width: width * (0.35),
                          child: Center(
                            child: Text(
                              lastGame.golE2.toString(),
                              style: kTextStyle.copyWith(fontSize: kFontSize),
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
    );
  }
}
