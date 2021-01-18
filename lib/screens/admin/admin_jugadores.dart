import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/leagues_provider.dart';

class AdminJugadores extends StatefulWidget {
  Jugador jugador;
  AdminJugadores({this.jugador});

  @override
  _AdminJugadoresState createState() => _AdminJugadoresState();
}

class _AdminJugadoresState extends State<AdminJugadores> {
  bool error = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nombre = '';
  String apellido = '';
  int amarillas = 0;
  int dni = 0;
  int edad = 0;
  int goles = 69;
  int posicion = 0;
  int rojas = 0;
  String liga = Leagues.libre.toString();

  @override
  void initState() {
    print('init state de admin_jugadors: ${widget.jugador}');
    if (widget.jugador != null) {
      nombre = widget.jugador.nombre;
      apellido = widget.jugador.apellido;
      liga = widget.jugador.liga;
      amarillas = widget.jugador.amarillas;
      dni = widget.jugador.dni;
      edad = widget.jugador.edad;
      goles = widget.jugador.goles;
      posicion = widget.jugador.posicion;
      rojas = widget.jugador.rojas;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CardSettings(children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(child: Divider(color: kBordo, thickness: 5)),
                    Text('Editar Jugador', style: TextStyle(fontSize: 20)),
                    Expanded(child: Divider(color: kBordo, thickness: 5)),
                  ],
                ),
              ),
            ),
            children: <CardSettingsWidget>[
              CardSettingsText(
                label: 'Nombre',
                initialValue: nombre ?? '',
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un nombre';
                  else
                    return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => nombre = value,
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
              ),
              CardSettingsText(
                label: 'Apellido',
                initialValue: apellido,
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un apellido';
                  else
                    return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => apellido = value,
                onChanged: (value) {
                  setState(() {
                    apellido = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'DNI',
                initialValue: dni,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => dni = value,
                onChanged: (value) {
                  setState(() {
                    dni = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Goles',
                initialValue: goles,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => goles = value,
                onChanged: (value) {
                  setState(() {
                    goles = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Amarillas',
                initialValue: amarillas,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => amarillas = value,
                onChanged: (value) {
                  setState(() {
                    amarillas = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Rojas',
                initialValue: rojas,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => rojas = value,
                onChanged: (value) {
                  setState(() {
                    rojas = value;
                  });
                },
              ),
              CardSettingsListPicker(
                label: 'Liga',
                initialValue: liga,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    error = true;
                    return 'Hay que elegir una liga';
                  } else {
                    error = false;
                    return null;
                  }
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => liga = value,
                values: [
                  Leagues.libre.toString(),
                  Leagues.m30.toString(),
                  Leagues.m40.toString(),
                  Leagues.femenino.toString(),
                ],
                options: [
                  'libre',
                  'm30',
                  'm40',
                  'femenino',
                ],
                enabled: true,
                onChanged: (value) {
                  setState(() {
                    liga = value;
                  });
                },
              ),
              CardSettingsButton(
                label: 'Guardar',
                isDestructive: false,
                backgroundColor: kBordo,
                textColor: Colors.white,
                bottomSpacing: 4,
                onPressed: () {
                  //TODO: Guardar toda la informaciíon en hive
                  print('Aca se supone que se guarda todo');

                  if (!error) {
                    final jugadores =
                        Provider.of<JugadorData>(context, listen: false);
                    if (widget.jugador != null) {
                      jugadores.deletePlayer(widget.jugador);
                    }
                    var aux = Jugador(
                      nombre: nombre,
                      apellido: apellido,
                      amarillas: amarillas,
                      dni: dni,
                      edad: edad,
                      goles: goles,
                      liga: liga,
                      posicion: posicion,
                      rojas: rojas,
                    );
                    jugadores.createPlayer(aux);
                    print('guardando el jugador: ${aux.toString()}');

                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // if (!error) {
    //   Provider.of<JugadorData>(context, listen: false)
    //       .editPlayer(widget.jugador, widget.index);
    // }
    super.dispose();
  }
}
