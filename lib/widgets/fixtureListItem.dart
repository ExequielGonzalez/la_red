import 'package:flutter/material.dart';

import '../constants.dart';

class FixtureListItem extends StatelessWidget {
  final double width;
  final double height;

  final String equipo1;
  final String equipo2;
  final int numCancha;
  final String fecha;
  final String hora;

  final double scale = 0.043;

  FixtureListItem(
      {this.width,
      this.height,
      this.equipo1,
      this.equipo2,
      this.fecha,
      this.hora,
      this.numCancha});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: width * (0.01),
          right: width * (0.01),
          top: height * (0.005),
          bottom: 0),
      height: height * (0.0944),
      decoration: BoxDecoration(
        color: kBordo,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  width: width * (0.08),
                  height: width * (0.08),
//
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset("assets/images/fixture.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * (0.05),
                  vertical: height * (0.002),
                ),
                child: Container(
                  width: width * (0.08),
                  height: width * (0.08),
//
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset("assets/images/fixture.png"),
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
                    equipo1,
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    'vs',
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    equipo2,
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    'CANCHA $numCancha',
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: width * 0.3,
                    child: Text(
                      fecha,
                      style: kTextStyle.copyWith(fontSize: kFontSize),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    '$hora HS',
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
