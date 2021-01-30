import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugadores_equipo_provider.dart';
import 'package:la_red/size_config.dart';
import 'package:la_red/widgets/admin/dialog_add_jugadores_to_team.dart';
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
  List<Partido> partidosAnteriores = [];

  Uint8List foto;

  void initPhoto() async {
    foto =
        (await rootBundle.load("assets/images/logo.jpg")).buffer.asUint8List();
  }

  @override
  void initState() {
    print('init state de admin_equipos: ${widget.equipo}');
    // dev.debugger();
    if (widget.equipo != null) {
      nombre = widget.equipo.nombre;
      liga = widget.equipo.liga;
      golesFavor = widget.equipo.golesFavor;
      golesContra = widget.equipo.golesContra;

      partidosGanados = widget.equipo.partidosGanados;
      partidosEmpatados = widget.equipo.partidosEmpates;
      partidosPerdidos = widget.equipo.partidosPerdidos;
      puntos = widget.equipo.puntos;
      partidosJugados = widget.equipo.partidosJugados;
      foto = widget.equipo.photoURL;
      print(
          'Estos jugadores estan en el initState de la clase admin_equipos: ${widget.equipo.jugadores}');
      // jugadoresEquipo = widget.equipo.jugadores.cast<Jugador>();
      widget.equipo.jugadores.forEach((element) {
        jugadoresEquipo.add(element);
        print(
            'Y ahora estos jugadores estan en el initState de la clase admin_equipos: ${jugadoresEquipo}');
      });

      widget.equipo.partidosAnteriores.forEach((element) {
        partidosAnteriores.add(element);
      });
    } else
      initPhoto();
    Future.delayed(Duration.zero, () {
      final jugadoresProvider =
          Provider.of<JugadoresEquipo>(context, listen: false);
      jugadoresProvider.clearList();

      jugadoresProvider.addJugadores(jugadoresEquipo);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;
    final jugadoresProvider =
        Provider.of<JugadoresEquipo>(context, listen: false);

    // final jugadores = Provider.of<JugadorData>(context).getJugadoresSinEquipo();
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
                onSaved: (value) {
                  try {
                    setState(() {
                      foto = value;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                onChanged: (value) {
                  try {
                    setState(() {
                      foto = value;
                    });
                  } catch (e) {
                    print(e);
                  }
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
                    // dev.debugger();
                    final equipos =
                        Provider.of<EquipoData>(context, listen: false);
                    final jugadoresEdit =
                        Provider.of<JugadorData>(context, listen: false);
                    // Provider.of<EquipoData>(context, listen: false);
                    jugadoresEquipo = jugadoresProvider.jugadorEquipo;
                    var games = await Hive.openBox<Partido>(kBoxPartidos);
                    // dev.debugger();

                    if (widget.equipo != null) {
                      bool equals = true;
                      List<Jugador> _temporaryList = [];
                      jugadoresEquipo.forEach((element) {
                        if (!widget.equipo.jugadores.contains(element)) {
                          _temporaryList.add(element);
                          equals = false;
                        }
                      });

                      print(equals);
                      if (!equals) {
                        // jugadoresEquipo = _temporaryList;
                        // equipos.deleteTeam(widget.equipo);
                        print(
                            '--------------->>>>>>>>>>>>>son distintas<<<<<<<<<--------------------');
                        var players =
                            await Hive.openBox<Jugador>(kBoxJugadores);

                        jugadoresEquipo = jugadoresProvider.jugadorEquipo;
                        print(
                            'Aprete el boton de save: ${jugadoresProvider.jugadorEquipo}');

                        print(
                            '\ncreando equipo con jugadores: $jugadoresEquipo');

                        widget.equipo.nombre = nombre;
                        widget.equipo.liga = liga;

                        widget.equipo.puntos = puntos;
                        widget.equipo.partidosPerdidos = partidosPerdidos;
                        widget.equipo.partidosEmpates = partidosEmpatados;
                        widget.equipo.partidosGanados = partidosGanados;
                        widget.equipo.golesFavor = golesFavor;
                        widget.equipo.golesContra = golesContra;
                        widget.equipo.photoURL = foto;
                        widget.equipo.jugadores =
                            HiveList(players, objects: jugadoresEquipo);
                        partidosAnteriores =
                            HiveList(games, objects: partidosAnteriores);
                        widget.equipo.partidosJugados = partidosJugados;

                        equipos.editTeam(widget.equipo);
                        print(
                            'guardando el equipo: ${widget.equipo.toString()}');

                        widget.equipo.jugadores.forEach((element) {
                          element.hasTeam = true;
                          jugadoresEdit.editPlayer(element);
                        });
                        equipos.editTeam(widget.equipo);
                      } else {
                        print(
                            '----------------------->Se supone que son iguales<------------------');

                        var players =
                            await Hive.openBox<Jugador>(kBoxJugadores);

                        // dev.debugger();
                        print(
                            '\ncreando equipo con jugadores: $jugadoresEquipo');
                        widget.equipo.nombre = nombre;
                        widget.equipo.liga = liga;

                        widget.equipo.puntos = puntos;
                        widget.equipo.partidosPerdidos = partidosPerdidos;
                        widget.equipo.partidosEmpates = partidosEmpatados;
                        widget.equipo.partidosGanados = partidosGanados;
                        widget.equipo.golesFavor = golesFavor;
                        widget.equipo.golesContra = golesContra;
                        widget.equipo.photoURL = foto;
                        widget.equipo.jugadores =
                            HiveList(players, objects: jugadoresEquipo);
                        partidosAnteriores =
                            HiveList(games, objects: partidosAnteriores);
                        widget.equipo.partidosJugados = partidosJugados;

                        equipos.editTeam(widget.equipo);
                        // equipos.createTeam(aux);
                        print(
                            'guardando el equipo: ${widget.equipo.toString()}');

                        widget.equipo.jugadores.forEach((element) {
                          element.hasTeam = true;
                          jugadoresEdit.editPlayer(element);
                        });
                        equipos.editTeam(widget.equipo);
                      }
                    } else {
                      print(
                          '--------------->>>>>>>>>>>>>Es nuevito el team<<<<<<<<<--------------------');
                      var players = await Hive.openBox<Jugador>(kBoxJugadores);

                      jugadoresEquipo = jugadoresProvider.jugadorEquipo;
                      print(
                          'Aprete el boton de save: ${jugadoresProvider.jugadorEquipo}');

                      print('\ncreando equipo con jugadores: $jugadoresEquipo');
                      var aux = Equipo(
                        nombre: nombre,
                        liga: liga,
                        puntos: puntos,
                        partidosPerdidos: partidosPerdidos,
                        partidosEmpates: partidosEmpatados,
                        partidosGanados: partidosGanados,
                        golesFavor: golesFavor,
                        golesContra: golesContra,
                        partidosJugados: partidosJugados,
                        photoURL: foto,
                        jugadores: HiveList(players, objects: jugadoresEquipo),
                        partidosAnteriores:
                            HiveList(games, objects: partidosAnteriores),
                      );

                      equipos.createTeam(aux);
                      print('guardando el equipo: ${aux.toString()}');

                      aux.jugadores.forEach((element) {
                        element.hasTeam = true;

                        jugadoresEdit.editPlayer(element);
                      });
                      equipos.editTeam(aux);
                    }
                    jugadoresProvider.clearList();
                    Navigator.of(context).pop(true);
                  }
                },
              ),

              CardSettingsInt(
                enabled: false,
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

class CardJugadores extends StatelessWidget implements CardSettingsWidget {
  CardJugadores({
    // this.jugadoresSinEquipo,
    // this.jugadoresEquipo,
    visible = true,
  });

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;

    final jugadores = Provider.of<JugadorData>(context).getJugadoresSinEquipo();
    final jugadoresProvider = Provider.of<JugadoresEquipo>(context);
    var jugadoresEquipo = jugadoresProvider.jugadorEquipo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: height * 0.04,
          child: FlatButton(
            child: Icon(Icons.add),
            onPressed: () async {
              List<Jugador> aux = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogAddJugadoresToTeam(
                      jugadores: jugadores,
                    );
                  });
              print(aux);

              // widget.jugadoresDelEquipo = aux ?? widget.jugadoresDelEquipo;
              if (aux != null) jugadoresProvider.addJugadores(aux);
            },
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: height * 0.15,
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
                        // widget.jugadoresDelEquipo[index].hasTeam = false;
                        // widget.jugadoresDelEquipo
                        //     .remove(widget.jugadoresDelEquipo[index]);
                        jugadoresProvider.deleteJugador(
                            context, jugadoresEquipo[index]);
                        // jugadoresEquipo[index].hasTeam = false;
                        // jugadoresEquipo.remove(jugadoresEquipo[index]);
                      },
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  @override
  // TODO: implement showMaterialonIOS
  bool get showMaterialonIOS => throw UnimplementedError();

  @override
  // TODO: implement visible
  bool get visible => true;
}
