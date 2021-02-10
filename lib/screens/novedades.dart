import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:la_red/main.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:la_red/widgets/background_template.dart';

import '../constants.dart';

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
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: getHeight(0.5),
                width: getWidth(0.85), //
                margin: EdgeInsets.only(
                  left: getWidth(0.056), //
                  right: getWidth(0.056), //
                  top: getHeight(0.029), //
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
                    Text("Para mantener actulizados los datos de la app LA RED"
                        " realice los siguientes pasos en su dispositivo: \n\n"
                        "1. Abre Google Play Store. \n"
                        "2. Presiona Menú y luego Mis apps y juegos.\n"
                        "3. Selecciona la app LA RED (haciendo click en el icono).\n"
                        "4. Presiona Más (los tres puntos arriba a la derecha).\n"
                        "5. Presiona Habilitar o marcar el casillero 'Actualizar automáticamente' .\n"),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: getWidth(0.50),
                height: getHeight(0.10),
                onPressed: () {
                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("¡Problema solucionado!"),
                    content: Text(
                        "Presiona el botón para reiniciar la aplicación con todos tus datos actualizados 😁"),
                    actions: [
                      FlatButton(
                          onPressed: () async {
                            print('aca se borra la DB');
                            var boxConfig = await Hive.openBox(kBoxConfig);
                            var boxJugadores = await Hive.openBox<Jugador>(
                              kBoxJugadores,
                            );
                            var boxEquipos = await Hive.openBox<Equipo>(
                              kBoxEquipos,
                            );
                            var boxPartidos = await Hive.openBox<Partido>(
                              kBoxPartidos,
                            );
                            boxJugadores.clear();
                            boxEquipos.clear();
                            boxPartidos.clear();
                            await boxConfig.put('lastReadJugador', -1);
                            await boxConfig.put('lastReadEquipo', -1);
                            await boxConfig.put('lastReadPartido', -1);

                            RestartWidget.restartApp(context);
                          },
                          child: Text('Presioname 🤗')),
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(getWidth(0.07)),
                  //side: BorderSide(color: Colors.black),
                ),
                child: Text(
                  "No se me actualizan los datos 😫",
                  style: kTextStyleBold.copyWith(
                      fontSize: getHeight(0.024), color: kBordo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
