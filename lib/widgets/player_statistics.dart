import 'package:flutter/cupertino.dart';
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
  final List<Jugador> jugadores;
  final String titulo;

  PlayerStatitistics({this.equipo, this.jugadores, this.titulo});

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
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.025),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: height * (0.005)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: height * (0.029),
                ),
                // height: height * (0.16), //
                decoration: BoxDecoration(
                  color: kBordo,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * (0.05), width * (0.05), width * (0.05), 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: gridPadding),
                            child: Container(
                              width: width * (2 * gridWidth),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.solidFutbol,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: gridPadding),
                            child: Container(
                              width: width * (2 * gridWidth),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.squareFull,
                                  color: Colors.yellow[600],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: gridPadding),
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
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: jugadores == null
                            ? equipo.jugadores.length
                            : jugadores.length,
                        itemBuilder: (context, index) {
                          return PlayerList(
                              gridPadding: gridPadding,
                              height: height,
                              jugador: jugadores == null
                                  ? equipo.jugadores[index]
                                  : jugadores[index],
                              width: width,
                              gridWidth: gridWidth);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * (0.05), vertical: height * 0.005),
                child: Text(
                  titulo == null ? 'ESTADíSTICAS' : titulo,
                  style: kTextStyleBold.copyWith(
                      color: kBordo, fontSize: kFontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  PlayerList({
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

  final fontColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * (0.08),
      // height: height * (0.04),
      decoration: BoxDecoration(
        color: kBordo,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
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
                    '${jugador.apellido} ${jugador.nombre}',
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
      ),
    );
  }
}
