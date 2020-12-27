import 'package:flutter/material.dart';

import '../constants.dart';

class EquiposListItem extends StatelessWidget {
  final double width;
  final double height;

  final Function onTap;

  final String nombre;

  EquiposListItem({this.width, this.height, this.nombre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
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
                width: width * (0.114),
                height: width * (0.114),
//
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset("assets/images/fixture.png"),
                ),
              ),
            ),
            Text(
              nombre,
              style: kTextStyle.copyWith(fontSize: kFontSize),
            )
          ],
        ),
      ),
    );
  }
}
