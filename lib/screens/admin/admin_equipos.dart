import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugadores_equipo_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

import '../../provider/jugador_data.dart';
import '../../provider/leagues_provider.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:developer' as dev;

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
  bool init = false;

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

  List<Jugador> jugadoresEquipo = [];

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
      jugadoresEquipo = widget.equipo.jugadores.cast<Jugador>();
    } else
      initPhoto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;
    // if (widget.equipo == null)
    final jugadoresEquipo = Provider.of<JugadoresEquipo>(context).jugadorEquipo;
    final jugadores = Provider.of<JugadorData>(context).getJugadoresSinEquipo();
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

              // CardSettingsCheckboxPicker(
              //   label: 'Jugadores',
              //   //TODO: Aqui mostrar los jugadores del equipo
              //   initialValues: [],
              //   validator: (List<String> value) {
              //     if (value == null || value.isEmpty)
              //       return 'Este equipo no tiene jugadores';
              //     return null;
              //   },
              //   autovalidateMode: _autoValidateMode,
              //   onSaved: (value) => league.setLeagueString(value.first),
              //   //TODO: Mostrar los jugadores sin equipo
              //   // options: jugadores
              //   //     .map((value) => value.hasTeam ? value.nombre : null)
              //   //     .toList(),
              //   options: jugadoresSinEquipo
              //       .map((element) => element.nombre + ' ' + element.apellido)
              //       .toList(),
              //   //TODO: Revisar
              //   enabled: true,
              //   onChanged: (value) {
              //     jugadoresSinEquipo.forEach((element) {});
              //     setState(() {
              //       print('jugador seleccionado: $value');
              //       print('${value.length}');
              //     });
              //   },
              // ), //jugadores
              CardJugadores(
                // jugadoresSinEquipo: jugadoresSinEquipo,
                visible: true,
                // jugadoresDelEquipo: jugadoresEquipo,
              ),
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
                    final equipos =
                        Provider.of<EquipoData>(context, listen: false);
                    if (widget.equipo != null) {
                      equipos.deleteTeam(widget.equipo);
                    }
                    var players = await Hive.openBox<Jugador>(kBoxJugadores);
                    var teamEdited = await Hive.openBox<Equipo>(kBoxEquipos);
                    dev.debugger();
                    players.addAll(jugadoresEquipo
                        .where((element) => jugadores.contains(element.key)));
                    // players.addAll(jugadoresEquipo);
                    // aux.jugadores = HiveList(players);
                    print('\ncreando equipo con jugadores: $jugadoresEquipo');
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
                      jugadores: HiveList(players),
                    );
                    // await teamEdited.add(aux);

                    equipos.createTeam(aux);
                    print('guardando el jugador: ${aux.toString()}');
                    aux.jugadores.addAll(jugadoresEquipo
                        .where((element) => jugadores.contains(element.key)));
                    print('estos jugadores del orto deberian entrar: ${aux.jugadores}');
                    // await aux.save();
                    equipos.editTeam(aux);

                    Navigator.of(context).pop(true);
                  }
                },
              ),
              // CardSettingsButton(
              //   label: 'Añadir jugador al equipo',
              //   isDestructive: false,
              //   backgroundColor: kBordo,
              //   textColor: Colors.white,
              //   bottomSpacing: 4,
              //   onPressed: () {
              //     //TODO: abrir un dialog y seleccionar de los jugadores disponibles
              //     print('prueba');
              //   },
              // ),
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

class CardJugadores extends StatefulWidget implements CardSettingsWidget {
  @override
  // List<Jugador> jugadoresSinEquipo = [];
  // List<Jugador> jugadoresDelEquipo;

  CardJugadores({
    // this.jugadoresSinEquipo,
    // this.jugadoresDelEquipo,
    visible = true,
  });

  _CardJugadoresState createState() => _CardJugadoresState();

  @override
  // TODO: implement showMaterialonIOS
  bool get showMaterialonIOS => throw UnimplementedError();

  @override
  // TODO: implement visible
  bool get visible => true;
}

class _CardJugadoresState extends State<CardJugadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    final jugadores = Provider.of<JugadorData>(context).getJugadoresSinEquipo();
    final jugadoresEquipo = Provider.of<JugadoresEquipo>(context).jugadorEquipo;
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: getHeight(0.02),
          child: FlatButton(
            child: Icon(Icons.add),
            onPressed: () async {
              List<Jugador> aux = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogJugadores(
                      jugadores: jugadores,
                    );
                  });
              print(aux);
              setState(() {
                // widget.jugadoresDelEquipo = aux ?? widget.jugadoresDelEquipo;
                aux == null ? null : jugadoresEquipo.addAll(aux);
              });
            },
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: getHeight(0.2),
            minHeight: 0,
          ),
          child: ListView.builder(
              // itemExtent: getHeight(0.05),
              // itemCount: widget.jugadoresDelEquipo.length,
              itemCount: jugadoresEquipo.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 5),
                  child: Container(
                    color: Colors.grey.shade50,
                    child: InkWell(
                      child: Text(
                        // '${widget.jugadoresDelEquipo[index].nombre} ${widget.jugadoresDelEquipo[index].apellido}',
                        '${jugadoresEquipo[index].nombre} ${jugadoresEquipo[index].apellido}',
                        style: kTextStyle.copyWith(
                            color: Colors.black, fontSize: 14),
                      ),
                      onLongPress: () {
                        setState(() {
                          // widget.jugadoresDelEquipo[index].hasTeam = false;
                          // widget.jugadoresDelEquipo
                          //     .remove(widget.jugadoresDelEquipo[index]);
                          jugadoresEquipo[index].hasTeam = false;
                          jugadoresEquipo.remove(jugadoresEquipo[index]);
                        });
                      },
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class DialogJugadores extends StatefulWidget {
  @override
  List<Jugador> jugadores = [];
  DialogJugadores({this.jugadores});
  _DialogJugadoresState createState() => _DialogJugadoresState();
}

class _DialogJugadoresState extends State<DialogJugadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  List<Jugador> _aux = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Lista de jugadores'),
      content: Container(
        height: getHeight(0.9), // Change as per your requirement
        width: getWidth(0.9), // Change as per your requirement
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.jugadores.length ?? 0,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: widget.jugadores[index].hasTeam,
                      onChanged: (bool value) => setState(() {
                        widget.jugadores[index].hasTeam = value;
                      }),
                      title: Text(
                          '${widget.jugadores[index].nombre} ${widget.jugadores[index].apellido}'),
                    );
                  }),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Añadir",
            style: TextStyle(color: kBordo),
          ),
          onPressed: () async {
//Añadiendo jugador al equipo

            widget.jugadores.forEach((element) {
              if (element.hasTeam) _aux.add(element);
            });

            Navigator.of(context).pop(_aux);
          },
        ),
        FlatButton(
          child: Text(
            "Salir",
            style: TextStyle(color: kBordo),
          ),
          onPressed: () {
//Put your code here which you want to execute on Cancel button click.

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
