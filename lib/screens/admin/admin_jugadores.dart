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
  DateTime nacimiento = DateTime.now();
  int goles = 0;
  int posicion = 0;
  int rojas = 0;
  bool hasTeam = false;
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
      nacimiento = widget.jugador.nacimiento;
      goles = widget.jugador.goles;
      rojas = widget.jugador.rojas;
      hasTeam = widget.jugador.hasTeam;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LeaguesProvider league = Provider.of<LeaguesProvider>(context);
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
                enabled: widget.jugador == null ? true : false,
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => dni = value,
                onChanged: (value) {
                  setState(() {
                    dni = value;
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
                enabled: widget.jugador == null ? true : false,
                onChanged: (value) {
                  setState(() {
                    liga = value;
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
                enabled: false,
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
                enabled: false,
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
                enabled: false,
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => rojas = value,
                onChanged: (value) {
                  setState(() {
                    rojas = value;
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
                    // if (widget.jugador != null) {
                    //   jugadores.deletePlayer(widget.jugador);
                    // }
                    var aux = Jugador(
                      nombre: nombre,
                      apellido: apellido,
                      amarillas: amarillas,
                      dni: dni,
                      nacimiento: nacimiento,
                      goles: goles,
                      liga: liga,
                      rojas: rojas,
                      hasTeam: hasTeam,
                    );
                    if (widget.jugador != null) {
                      widget.jugador.nombre = nombre;
                      widget.jugador.apellido = apellido;
                      widget.jugador.liga = liga;
                      widget.jugador.amarillas = amarillas;
                      widget.jugador.dni = dni;
                      widget.jugador.nacimiento = nacimiento;
                      widget.jugador.goles = goles;
                      widget.jugador.rojas = rojas;
                      widget.jugador.hasTeam = hasTeam;

                      // widget.jugador.save();
                      jugadores.editPlayer(widget.jugador);
                    } else
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
