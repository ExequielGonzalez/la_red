import 'package:flutter/material.dart';
import 'package:la_red/widgets/background_template.dart';

class Novedades extends StatefulWidget {
  @override
  _NovedadesState createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'novedades',
        child: Expanded(
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
