import 'package:cloud_firestore/cloud_firestore.dart';
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
      resizeToAvoidBottomInset: false,
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'Tutorial',
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  // height: getHeight(0.5),
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
                      Text(
                          "Para mantener actulizados los datos de la app LA RED"
                          " realice los siguientes pasos en su dispositivo: \n\n"
                          "1. Abre Google Play Store. \n"
                          "2. Presiona Menú y luego Mis apps y juegos.\n"
                          "3. Selecciona la app LA RED (haciendo click en el icono).\n"
                          "4. Presiona Más (los tres puntos arriba a la derecha).\n"
                          "5. Presiona Habilitar o marcar el casillero 'Actualizar automáticamente' .\n"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getHeight(0.01)),
                child: MaterialButton(
                  minWidth: getWidth(0.50),
                  height: getHeight(0.10),
                  onPressed: () async {
                    var boxConfig = await Hive.openBox(kBoxConfig);
                    int canClean = await boxConfig.get('canCleanDataBase',
                        defaultValue: -1);
                    // set up the AlertDialog

                    if (canClean == -1) {
                      AlertDialog cleanDialog = AlertDialog(
                        title: Text("Solucionador de Problemas"),
                        content: Text(
                            "Presiona el botón para reiniciar la aplicación con todos tus datos actualizados"),
                        actions: [
                          FlatButton(
                              onPressed: () async {
                                print('aca se borra la DB');

                                if (canClean == -1) {
                                  var boxJugadores =
                                      await Hive.openBox<Jugador>(
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
                                  await boxConfig.put('canCleanDataBase', 1);

                                  RestartWidget.restartApp(context);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Solucionar')),
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return cleanDialog;
                        },
                      );
                    } else {
                      AlertDialog cleanDialog = AlertDialog(
                        title: Text("Ups!"),
                        content: Text(
                            "Por favor envíanos un mensaje explicándonos tu problema para poder encontrarle una solución"),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cerrar')),
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return cleanDialog;
                        },
                      );
                    }
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getWidth(0.07)),
                    //side: BorderSide(color: Colors.black),
                  ),
                  child: Container(
                    width: getWidth(0.75),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "No se me actualizan los datos",
                          style: kTextStyleBold.copyWith(
                            fontSize: getHeight(0.024),
                            color: kBordo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: getHeight(0.01)),
                child: MaterialButton(
                  minWidth: getWidth(0.50),
                  height: getHeight(0.10),
                  onPressed: () async {
                    final _nombre = TextEditingController();
                    final _email = TextEditingController();
                    final _mensaje = TextEditingController();

                    AlertDialog contact = AlertDialog(
                      scrollable: true,
                      title: Text('¡Contactanos!'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Nombre',
                                  icon: Icon(Icons.account_box),
                                ),
                                controller: _nombre,
                              ),
                              TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email),
                                ),
                              ),
                              TextFormField(
                                controller: _mensaje,
                                maxLines: 5,
                                minLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  labelText: 'Mensaje',
                                  icon: Icon(Icons.message),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        RaisedButton(
                            child: Text("Enviar"),
                            onPressed: () async {
                              if (_mensaje.text.length != 0) {
                                final firestoreInstance =
                                    FirebaseFirestore.instance;
                                await firestoreInstance
                                    .collection("mensajes")
                                    .doc(
                                        '${DateTime.now().millisecondsSinceEpoch}')
                                    .set(
                                  {
                                    'nombre': _nombre.text,
                                    'email': _email.text,
                                    'mensaje': _mensaje.text
                                  },
                                  SetOptions(merge: true),
                                );
                              }
                              Navigator.pop(context);
                            }),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return contact;
                      },
                    );
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getWidth(0.07)),
                    //side: BorderSide(color: Colors.black),
                  ),
                  child: Container(
                    width: getWidth(0.75),
                    child: Center(
                      child: Text(
                        "¡Contactanos!",
                        style: kTextStyleBold.copyWith(
                            fontSize: getHeight(0.024), color: kBordo),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
