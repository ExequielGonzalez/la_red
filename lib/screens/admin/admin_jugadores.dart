import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/leagues_provider.dart';

class AdminJugadores extends StatefulWidget {
  @override
  _AdminJugadoresState createState() => _AdminJugadoresState();
}

class _AdminJugadoresState extends State<AdminJugadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  String nombre = "Exequiel";
  String apellido = "Gonzalez";
  int rojas = 0;
  int amarillas = 0;
  int dni = 0;
  int goles = 0;

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
                initialValue: nombre,
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un nombre';
                  else
                    return null;
                },
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
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                onSaved: (value) => rojas = value,
                onChanged: (value) {
                  setState(() {
                    rojas = value;
                  });
                },
              ),
              CardSettingsListPicker(
                label: 'Liga',
                initialValue: league.currentLeagueString,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Hay que elegir una liga';

                  return null;
                },
                onSaved: (value) => league.setLeagueString(value),
                values: ['L', '30', '40', 'F'],
                options: [
                  'libre',
                  'm40',
                  'm30',
                  'femenino',
                ],
                enabled: true,
                onChanged: (value) {
                  setState(() {
                    league.setLeagueString(value);
                  });
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
