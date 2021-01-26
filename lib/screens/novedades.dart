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
        title: 'Tutorial',
        child: Container(
            height: getHeight(0.60),
            width: getWidth(0.85),   //
            margin: EdgeInsets.only(
              left: getWidth(0.056),  //
              right: getWidth(0.056),  //
              top: getHeight(0.029),  //
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(0.046),
              vertical: 0.00004,
            ),
            //padding: EdgeInsets.all(15),  //Margenes internos entre el scaffold y el container
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),

            child: ListView(

              children: [
                Text( "Para mantener actulizados los datos de la app LA RED"
                    " realice los siguientes pasos en su dispositivo: \n\n"
                    "1. Abre Google Play Store. \n"
                    "2. Presiona Menú y luego Mis apps y juegos.\n"
                    "3. Selecciona la app LA RED (haciendo click en el icono).\n"
                    "4. Presiona Más (los tres puntos arriba a la derecha).\n"
                    "5. Presiona Habilitar o marcar el casillero 'Actualizar automáticamente' .\n"
                ),

              ],
            )
        ),
      ),
    );
  }
}