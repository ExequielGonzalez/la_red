import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/size_config.dart';

class PlayerStatitistics extends StatelessWidget {
  double width;
  double height;

  final Equipo equipo;

  PlayerStatitistics({
    this.equipo,
  });

  final double scale = 0.045;
  final double gridPadding = 1;
  final double gridWidth = 0.05;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: height * (0.005)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * (0.05), width * (0.05), width * (0.05), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: gridPadding),
                    child: Container(
                      width: width * (2 * gridWidth),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.futbol),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: gridPadding),
                    child: Container(
                      width: width * (2 * gridWidth),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.squareFull,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: gridPadding),
                    child: Container(
                      width: width * (2 * gridWidth),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.squareFull,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: equipo.jugadores.length,
              itemBuilder: (context, index) {
                return PlayerList(
                    gridPadding: gridPadding,
                    height: height,
                    jugador: equipo.jugadores[index],
                    width: width,
                    gridWidth: gridWidth);
              },
            )
          ],
        ),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  const PlayerList({
    @required this.gridPadding,
    @required this.height,
    @required this.jugador,
    @required this.width,
    @required this.gridWidth,
  });

  final double gridPadding;
  final double height;
  final Jugador jugador;
  final double width;
  final double gridWidth;

  final fontColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: height * 0.025,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${jugador.nombre} ${jugador.apellido}',
                  style: kTextStyle.copyWith(
                      fontSize: kFontSize, color: fontColor),
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
                  '${jugador.goles}',
                  style: kTextStyle.copyWith(
                    color: fontColor,
                    fontSize: kFontSize,
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
                  '${jugador.amarillas}',
                  style: kTextStyle.copyWith(
                    color: fontColor,
                    fontSize: kFontSize,
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
                  '${jugador.rojas}',
                  style: kTextStyle.copyWith(
                    color: fontColor,
                    fontSize: kFontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
