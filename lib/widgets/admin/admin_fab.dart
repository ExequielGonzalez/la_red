import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/screens/admin/admin_equipos.dart';
import 'package:la_red/screens/admin/admin_jugadores.dart';
import 'package:la_red/widgets/admin/admin_dialog_jugadores.dart';

import '../../size_config.dart';

class AdminFAB extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;
    return FabCircularMenu(
      key: fabKey,
      // Cannot be `Alignment.center`
      alignment: Alignment.bottomRight,
      ringColor: kBordo.withAlpha(200),
      ringDiameter: width * 0.8,
      ringWidth: width * 0.2,
      fabSize: width * 0.15,
      fabElevation: 8.0,
      fabIconBorder: CircleBorder(),
      // Also can use specific color based on wether
      // the menu is open or not:
      // fabOpenColor: Colors.white
      // fabCloseColor: Colors.white
      // These properties take precedence over fabColor
      fabColor: kBordo.withAlpha(200),
      fabOpenIcon: Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: Icon(Icons.close, color: Colors.white),
      fabMargin: EdgeInsets.all(width * 0.08),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {
        print("The menu is ${isOpen ? "open" : "closed"}");
      },
      children: <Widget>[
        RawMaterialButton(
            onPressed: () {
              print("Abriendo Menú para editar Equipos");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEquipos()),
              );
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            // child: Icon(Icons.looks_one, color: Colors.white),
            child: MenuButton(
              text: 'Equipos',
            )),
        Container(
          width: 1,
          height: 1,
        ),
        Container(
          width: 1,
          height: 1,
        ),
        RawMaterialButton(
          onPressed: () async {
            print("Abriendo Menú para editar Jugadores");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdminDialogJugadores();
                });
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: MenuButton(
            text: 'Jugadores',
          ),
        ),
        Container(
          width: 1,
          height: 1,
        ),
        Container(
          width: 1,
          height: 1,
        ),
        Container(
          width: 1,
          height: 1,
        ),
        RawMaterialButton(
            onPressed: () {
              print("Abriendo Menú para editar partidos");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: MenuButton(
              text: 'Partidos',
            )),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;

  MenuButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextStyle.copyWith(fontSize: kFontSize, color: Colors.white),
    );
  }
}
