import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';

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
              padding: EdgeInsets.symmetric(horizontal: width * 0.043),
              child: Text(
                '$posicion',
                style: kTextStyle.copyWith(fontSize: width * (scale * 0.8)),
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
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Image.asset("assets/images/fixture.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: width * (0.336),
                child: Text(
                  name,
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Container(
                width: width * (1.6 * gridWidth),
                child: Center(
                  child: Text(
                    '$puntos',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
                    '$golesContra',
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontSize: width * (scale * 0.8)),
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
