import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/jugador.dart';

import '../size_config.dart';

class GoleadoresListItem extends StatelessWidget {
  double width;
  double height;

  final Jugador jugador;

  GoleadoresListItem({this.jugador});

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
              padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.02, 0),
              child: Container(
                width: width * 0.06,
                child: Text(
                  '${jugador.posicion}',
                  style: kTextStyle.copyWith(fontSize: kFontSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                child: Text(
                  jugador.nombre,
                  style: kTextStyle.copyWith(fontSize: kFontSize),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.11),
              child: Container(
                child: Center(
                  child: Text(
                    '${jugador.goles}',
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
