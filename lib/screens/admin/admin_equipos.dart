import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

import '../../provider/jugador_data.dart';
import '../../provider/leagues_provider.dart';
import 'package:file_picker/file_picker.dart';

class AdminEquipos extends StatefulWidget {
  Equipo equipo;
  AdminEquipos({this.equipo});

  @override
  _AdminEquiposState createState() => _AdminEquiposState();
}

class _AdminEquiposState extends State<AdminEquipos> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool error = false;

  String nombre = '';
  String liga = '';
  int golesFavor = 0;
  int golesContra = 0;
  int posicion = 0;
  int partidosGanados = 0;
  int partidosEmpatados = 0;
  int partidosPerdidos = 0;
  int puntos = 0;
  int partidosJugados = 0;

  Uint8List foto;

  void initPhoto() async {
    foto = (await rootBundle.load("assets/images/logo_principal.png"))
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    print('init state de admin_equipos: ${widget.equipo}');
    if (widget.equipo != null) {
      nombre = widget.equipo.nombre;
      liga = widget.equipo.liga;
      golesFavor = widget.equipo.golesFavor;
      golesContra = widget.equipo.golesContra;
      posicion = widget.equipo.posicion;
      partidosGanados = widget.equipo.partidosGanados;
      partidosEmpatados = widget.equipo.partidosEmpates;
      partidosPerdidos = widget.equipo.partidosPerdidos;
      puntos = widget.equipo.puntos;
      partidosJugados = widget.equipo.partidosJugados;
      foto = widget.equipo.photoURL;
    } else
      initPhoto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;
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
                    Text('Editar Equipo', style: TextStyle(fontSize: 20)),
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
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => nombre = value,
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
              ), //Nombre
              CardSettingsFilePicker(
                label: 'Logo',
                fileType: FileType.image,
                initialValue: foto,
                requiredIndicator:
                    Text('*', style: TextStyle(color: Colors.red)),
                icon: Icon(Icons.photo),
                unattachDialogTitle: 'Desea eliminar la imagen',
                unattachDialogConfirm: "si",
                unattachDialogCancel: "No",
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Se requiere un logo';
                  else
                    return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => foto = value,
                onChanged: (value) {
                  setState(() {
                    // List<int> aux = value;
                    // print(aux);
                    // aux.asMap().forEach((index, element) {
                    //   if (element >= 255 || element < 0)
                    //     print('Aca esta el putito, en index: ${index}');
                    // });
                    // //TODO:ARREGLAR ESTO, para poder usar las fotos como logo de los equipos
                    // // foto = BinaryReader.utf8Decoder.convert(value).toString();
                    // print(foto);
                    foto = value;
                  });
                },
              ), //foto

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

              CardSettingsCheckboxPicker(
                label: 'Jugadores',
                //TODO: Aqui mostrar los jugadores del equipo
                initialValues: ['uno', 'dos'],
                validator: (List<String> value) {
                  if (value == null || value.isEmpty)
                    return 'Hay que elegir una liga';
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => league.setLeagueString(value.first),
                //TODO: Mostrar los jugadores sin equipo
                options: equipos.map((value) => value.nombre).toList(),
                //TODO: Revisar
                enabled: true,
                onChanged: (value) {
                  setState(() {
                    league.setLeagueString(value.first);
                  });
                },
              ), //jugadores
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
                    final equipos =
                        Provider.of<EquipoData>(context, listen: false);
                    if (widget.equipo != null) {
                      equipos.deleteTeam(widget.equipo);
                    }
                    var aux = Equipo(
                      nombre: nombre,
                      liga: liga,
                      posicion: posicion,
                      puntos: puntos,
                      partidosPerdidos: partidosPerdidos,
                      partidosEmpates: partidosEmpatados,
                      partidosGanados: partidosGanados,
                      golesFavor: golesFavor,
                      golesContra: golesContra,
                      partidosJugados: partidosJugados,
                      photoURL: foto,
                    );
                    equipos.createTeam(aux);
                    print('guardando el jugador: ${aux.toString()}');

                    Navigator.of(context).pop(true);
                  }
                },
              ),
              CardSettingsButton(
                label: 'Añadir jugador al equipo',
                isDestructive: false,
                backgroundColor: kBordo,
                textColor: Colors.white,
                bottomSpacing: 4,
                onPressed: () {
                  //TODO: abrir un dialog y seleccionar de los jugadores disponibles
                  print('prueba');
                },
              ),
              CardSettingsInt(
                enabled: true,
                label: 'Puntos',
                initialValue: puntos,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => puntos = value,
                onChanged: (value) {
                  setState(() {
                    puntos = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Posicion',
                initialValue: posicion,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => posicion = value,
                onChanged: (value) {
                  setState(() {
                    posicion = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Partidos jugados',
                initialValue: partidosJugados,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => partidosJugados = value,
                onChanged: (value) {
                  setState(() {
                    partidosJugados = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Partidos ganados',
                initialValue: partidosGanados,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => partidosGanados = value,
                onChanged: (value) {
                  setState(() {
                    partidosGanados = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Partidos empatados',
                initialValue: partidosEmpatados,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => partidosEmpatados = value,
                onChanged: (value) {
                  setState(() {
                    partidosEmpatados = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Partidos perdidos',
                initialValue: partidosPerdidos,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => partidosPerdidos = value,
                onChanged: (value) {
                  setState(() {
                    partidosPerdidos = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Goles a favor',
                initialValue: golesFavor,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => golesFavor = value,
                onChanged: (value) {
                  setState(() {
                    golesFavor = value;
                  });
                },
              ),
              CardSettingsInt(
                enabled: false,
                label: 'Goles en contra',
                initialValue: golesContra,
                contentAlign: TextAlign.right,
                validator: (value) {
                  if (value != null) {
                    if (value < 0) return 'El valor debe de ser mayor que 0';
                  }
                  return null;
                },
                autovalidateMode: _autoValidateMode,
                onSaved: (value) => golesContra = value,
                onChanged: (value) {
                  setState(() {
                    golesContra = value;
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
