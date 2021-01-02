import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/size_config.dart';

class PositionListItem extends StatelessWidget {
  final double width;
  final double height;

  final int posicion;
  final String name;
  final int puntos;
  final int partidosJugados;
  final int partidosGanados;
  final int partidosPerdidos;
  final int partidosEmpates;
  final int golesFavor;
  final int golesContra;

  PositionListItem(
      {this.width,
      this.height,
      this.posicion,
      this.name,
      this.puntos,
      this.partidosJugados,
      this.partidosEmpates,
      this.partidosGanados,
      this.partidosPerdidos,
      this.golesContra,
      this.golesFavor});

  final double scale = 0.045;
  final double gridPadding = 1;
  final double gridWidth = 0.05;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * (0.004),
        vertical: height * (0.001),
      ),
      child: Container(
        width: width * (0.08),
        height: height * (0.05),
//
        decoration: BoxDecoration(
          color: kBordo,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.01),
              child: Container(
                width: width * 0.05,
                child: Center(
                  child: Text(
                    '$posicion',
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Container(
              width: width * (0.08),
              height: width * (0.08),
//
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Image.asset("assets/images/fixture.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: gridPadding * 3),
                child: FittedBox(
                  // width: width * (0.336),
                  child: Text(
                    name.length < 18 ? name : name.substring(0, 17) + '...',
                    // name,
                    style: kTextStyle.copyWith(fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (2 * gridWidth),
                child: Center(
                  child: Text(
                    '$puntos',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (gridWidth),
                child: Center(
                  child: Text(
                    '$partidosJugados',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (gridWidth),
                child: Center(
                  child: Text(
                    '$partidosGanados',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (gridWidth),
                child: Center(
                  child: Text(
                    '$partidosEmpates',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (gridWidth),
                child: Center(
                  child: Text(
                    '$partidosPerdidos',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.4 * gridWidth),
                child: Center(
                  child: Text(
                    '$golesFavor',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: gridPadding, right: width * 0.015),
              child: Container(
                width: width * (1.4 * gridWidth),
                child: Center(
                  child: Text(
                    '$golesContra',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
