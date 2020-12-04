import 'package:flutter/material.dart';

import '../constants.dart';

class ScreenBanner extends StatelessWidget {
  final double height;
  final double width;

  ScreenBanner({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.056,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_principal.png",
              width: width * 0.322,
              height: width * 0.322,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                children: [
                  Text(
                    'LA RED',
                    style: kTextStyleBold.copyWith(fontSize: 51, height: 1),
                  ),
                  Text(
                    'Liga de fútbol',
                    style: kTextStyle.copyWith(fontSize: 23, height: 1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                    width: width * 0.305,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
