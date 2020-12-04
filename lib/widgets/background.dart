import 'package:flutter/material.dart';

import '../constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(kBordo.withOpacity(0.21), BlendMode.darken),
          image: AssetImage("assets/images/background.png"),
        ),
      ),
    );
  }
}
