import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/size_config.dart';

class PositionListItem extends StatelessWidget {
  double width;
  double height;

  final Equipo equipo;
  final int posicion;

  PositionListItem({
    this.equipo,
    this.posicion,
  });

  final double scale = 0.045;
  final double gridPadding = 1;
  final double gridWidth = 0.05;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;
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
                    '${this.posicion}',
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
                padding: EdgeInsets.all(width * 0.01),
                child: Image.memory(
                  equipo.photoURL,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: gridPadding * 6),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: height * 0.025,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      equipo.nombre.length < 18
                          ? equipo.nombre
                          : equipo.nombre.substring(0, 17) + '...',
                      // name,
                      style: kTextStyle.copyWith(fontSize: kFontSize),
                    ),
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
                    '${equipo.puntos}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.2 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.partidosJugados}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.2 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.partidosGanados}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.2 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.partidosEmpates}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.2 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.partidosPerdidos}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.2 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.golesFavor}',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: kFontSize),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: gridPadding, right: width * 0.015),
              child: Container(
                width: width * (1.43 * gridWidth),
                child: Center(
                  child: Text(
                    '${equipo.golesContra}',
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
