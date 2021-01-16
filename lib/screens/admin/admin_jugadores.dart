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
  String nombre = "Exequiel";
  String apellido = "Gonzalez";
  int rojas = 0;
  int amarillas = 0;
  int dni = 0;
  int goles = 0;

  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                initialValue: widget.jugador.nombre ?? '',
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un nombre';
                  else
                    return null;
                },
                onSaved: (value) => widget.jugador.nombre = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.nombre = value;
                  });
                },
              ),
              CardSettingsText(
                label: 'Apellido',
                initialValue: widget.jugador.apellido,
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un apellido';
                  else
                    return null;
                },
                onSaved: (value) => widget.jugador.apellido = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.apellido = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'DNI',
                initialValue: widget.jugador.dni,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                onSaved: (value) => widget.jugador.dni = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.dni = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Goles',
                initialValue: widget.jugador.goles,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                onSaved: (value) => widget.jugador.goles = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.goles = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Amarillas',
                initialValue: widget.jugador.amarillas,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                onSaved: (value) => widget.jugador.amarillas = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.amarillas = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Rojas',
                initialValue: widget.jugador.rojas,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                onSaved: (value) => widget.jugador.rojas = value,
                onChanged: (value) {
                  setState(() {
                    widget.jugador.rojas = value;
                  });
                },
              ),
              CardSettingsListPicker(
                label: 'Liga',
                initialValue: widget.jugador.liga,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    error = true;
                    return 'Hay que elegir una liga';
                  } else {
                    error = false;
                    return null;
                  }
                },
                onSaved: (value) => widget.jugador.liga = value,
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
                    widget.jugador.liga = value;
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
                    print('guardando el jugador: ${widget.jugador.toString()}');
                    Provider.of<JugadorData>(context, listen: false)
                        .editPlayer(widget.jugador);
                    Navigator.of(context).pop();
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
