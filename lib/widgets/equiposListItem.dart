import 'package:flutter/material.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/size_config.dart';

import '../constants.dart';

class EquiposListItem extends StatelessWidget {
  double width;
  double height;

  final Function onTap;

  final Equipo equipo;

  EquiposListItem({this.equipo, this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            // left: width * (0.02),
            left: width * (0.02),
            right: width * (0.02),
            top: height * (0.01),
            bottom: 0),
        height: height * (0.071),
        decoration: BoxDecoration(
          color: kBordo,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * (0.05),
                vertical: height * (0.002),
              ),
              child: Container(
                width: width * (0.1),
                height: width * (0.1),
//
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.009),
                  child: Image.asset(equipo.photoURL),
                ),
              ),
            ),
            Text(
              equipo.nombre,
              style: kTextStyle.copyWith(fontSize: kFontSize),
            )
          ],
        ),
      ),
    );
  }
}
