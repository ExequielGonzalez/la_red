import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';

class GoleadoresListItem extends StatelessWidget {
  final double width;
  final double height;

  final String name;
  final int goles;
  final int posicion;

  GoleadoresListItem(
      {this.height, this.width, this.name, this.goles, this.posicion});

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
              padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.02, 0),
              child: Container(
                width: width * 0.05,
                child: Text(
                  '$posicion',
                  style: kTextStyle.copyWith(fontSize: kFontSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                child: Text(
                  name,
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
                    '$goles',
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
