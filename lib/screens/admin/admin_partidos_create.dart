import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';

import 'package:la_red/model/partido.dart';
import 'package:la_red/provider/equipo_data.dart';

import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class AdminPartidosCreate extends StatefulWidget {
  Partido partido;
  AdminPartidosCreate({this.partido});

  @override
  _AdminPartidosCreateState createState() => _AdminPartidosCreateState();
}

class _AdminPartidosCreateState extends State<AdminPartidosCreate> {
  bool error = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Equipo equipo1;
  Equipo equipo2;
  int numCancha = 0;
  // DateTime fecha = DateTime(2020, 10, 10, 20, 30);
  DateTime fecha = DateTime.now();
  String hora = '';
  int golE1 = 0;
  int golE2 = 0;
  int id = 0;
  bool isFinished = false;
  String liga = Leagues.libre.toString();

  List<Equipo> equipos = [];
  String equipo1String = '';
  String equipo2String = '';

  @override
  void initState() {
    print('init state de admin_jugadors: ${widget.partido}');
    if (widget.partido != null) {
      equipo1 = widget.partido.equipo1.first;
      equipo2 = widget.partido.equipo2.first;
      numCancha = widget.partido.numCancha;
      liga = widget.partido.liga;
      fecha = widget.partido.fecha;
      hora = widget.partido.hora;
      golE1 = widget.partido.golE1;
      golE2 = widget.partido.golE2;
      id = widget.partido.id;
      isFinished = widget.partido.isFinished;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final equiposProvider = Provider.of<EquipoData>(context, listen: false);
    equipos = equiposProvider.getEquipos;
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
                    Text('Editar Partido', style: TextStyle(fontSize: 20)),
                    Expanded(child: Divider(color: kBordo, thickness: 5)),
                  ],
                ),
              ),
            ),
            children: <CardSettingsWidget>[
              CardSettingsListPicker(
                label: 'Equipo 1',
                initialValue: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    error = true;
                    return 'Hay que elegir un equipo';
                  } else if (value == 'NO HAY EQUIPOS') {
                    error = true;
                    return 'No hay equipos en esta liga';
                  } else {
                    error = false;
                    return null;
                  }
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => equipo1String = value,
                // values: equipos.map((e) => e.nombre).toList(),
                values: equipos.map((e) {
                  print(e.liga);
                  if (e.liga == league.currentLeague.toString())
                    return e.nombre;
                  else
                    return 'NO HAY EQUIPOS';
                }).toList(),
                // options: [
                //   'libre',
                //   'm30',
                //   'm40',
                //   'femenino',
                // ],
                options: equipos.map((e) {
                  print(e.liga);
                  if (e.liga == league.currentLeague.toString())
                    return e.nombre;
                  else
                    return 'NO HAY EQUIPOS';
                }).toList(),
                enabled: true,
                onChanged: (value) {
                  setState(() {
                    equipo1String = value;
                  });
                },
              ),
              CardSettingsListPicker(
                label: 'Equipo 2',
                initialValue: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    error = true;
                    return 'Hay que elegir un equipo';
                  } else if (equipo1String == equipo2String) {
                    error = true;
                    return 'Estas eligiendo el mismo equipo';
                  } else {
                    error = false;
                    return null;
                  }
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) =>
                    equipo1String != value ? equipo2String = value : '',
                values: equipos.map((e) => e.nombre).toList(),
                // options: [
                //   'libre',
                //   'm30',
                //   'm40',
                //   'femenino',
                // ],
                options: equipos.map((e) => e.nombre).toList(),
                enabled: true,
                onChanged: (value) {
                  setState(() {
                    if (equipo1String != equipo2String) equipo2String = value;
                  });
                },
              ),
              CardSettingsInt(
                label: 'Número de cancha',
                initialValue: numCancha,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => numCancha = value,
                onChanged: (value) {
                  setState(() {
                    numCancha = value;
                  });
                },
              ),
              CardSettingsDatePicker(
                icon: Icon(Icons.calendar_today),
                label: 'Fecha',
                dateFormat: DateFormat.yMMMMd(),
                initialValue: fecha,
                onSaved: (value) => fecha = updateJustDate(value, fecha),
                onChanged: (value) {
                  setState(() {
                    fecha = value;
                  });
                },
              ),
              CardSettingsTimePicker(
                icon: Icon(Icons.access_time),
                label: 'Hora',
                initialValue: TimeOfDay(hour: fecha.hour, minute: fecha.minute),
                onSaved: (value) => fecha = updateJustTime(value, fecha),
                onChanged: (value) {
                  setState(() {
                    fecha = updateJustTime(value, fecha);
                  });
                },
              ),
              // CardSettingsListPicker(
              //   label: 'Liga',
              //   initialValue: liga,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       error = true;
              //       return 'Hay que elegir una liga';
              //     } else {
              //       error = false;
              //       return null;
              //     }
              //   },
              //   autovalidateMode: _autoValidateMode,
              //   onSaved: (value) => liga = value,
              //   values: [
              //     Leagues.libre.toString(),
              //     Leagues.m30.toString(),
              //     Leagues.m40.toString(),
              //     Leagues.femenino.toString(),
              //   ],
              //   options: [
              //     'libre',
              //     'm30',
              //     'm40',
              //     'femenino',
              //   ],
              //   enabled: true,
              //   onChanged: (value) {
              //     setState(() {
              //       liga = value;
              //     });
              //   },
              // ),
              CardSettingsButton(
                label: 'Guardar',
                isDestructive: false,
                backgroundColor: kBordo,
                textColor: Colors.white,
                bottomSpacing: 4,
                onPressed: () async {
                  //TODO: Guardar toda la informaciíon en hive
                  print('Aca se supone que se guarda todo');

                  if (!error) {
                    var teams = await Hive.openBox<Equipo>(kBoxEquipos);
                    final partidos =
                        Provider.of<PartidoData>(context, listen: false);
                    equipos.forEach((element) {
                      if (element.nombre == equipo1String) equipo1 = element;
                      if (element.nombre == equipo2String) equipo2 = element;
                    });

                    List<Equipo> aux1 = [];
                    List<Equipo> aux2 = [];
                    aux1.add(equipo1);
                    aux2.add(equipo2);

                    var aux = Partido(
                      equipo1: HiveList(teams, objects: aux1),
                      equipo2: HiveList(teams, objects: aux2),
                      golE1: golE1,
                      golE2: golE2,
                      fecha: fecha,
                      hora: hora,
                      isFinished: isFinished,
                      numCancha: numCancha,
                      liga: liga,
                    );

                    partidos.createMatch(aux);
                    print('guardando el partido: ${aux.toString()}');

                    var games = await Hive.openBox<Partido>(kBoxPartidos);

                    List<Partido> _aux1 =
                        aux.equipo1.first.partidosAnteriores ?? [];
                    print('Ya hay ${aux1.length} partidos creados ');
                    List<Partido> _aux2 =
                        aux.equipo2.first.partidosAnteriores ?? [];

                    _aux1.add(aux);
                    _aux2.add(aux);

                    print('Ya hay ${aux1.length} partidos creados ');
                    aux.equipo1.first.partidosAnteriores =
                        HiveList(games, objects: _aux1);
                    aux.equipo2.first.partidosAnteriores =
                        HiveList(games, objects: _aux2);

                    aux.equipo1.first.save();
                    aux.equipo2.first.save();
                  }
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
