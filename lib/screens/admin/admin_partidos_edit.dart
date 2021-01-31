import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:la_red/size_config.dart';
import 'package:la_red/widgets/admin/dialog_show_jugadores.dart';
import 'package:la_red/widgets/player_statistics.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AdminPartidosEdit extends StatefulWidget {
  Partido partido;
  AdminPartidosEdit({this.partido});

  @override
  _AdminPartidosEditState createState() => _AdminPartidosEditState();
}

class _AdminPartidosEditState extends State<AdminPartidosEdit> {
  double width;
  double height;

  bool error = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Equipo equipo1;
  Equipo equipo2;
  int numCancha = 0;

  DateTime fecha = DateTime.now();

  int golE1 = 0;
  int golE2 = 0;
  String id = '';
  bool isFinished = false;
  String liga = Leagues.libre.toString();

  List<Equipo> equipos = [];
  String equipo1String = '';
  String equipo2String = '';

  void addGol(context, Equipo equipo) async {
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    Jugador aux = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogShowJugadores(
            jugadores: equipo.jugadores,
          );
        });
    if (aux != null) {
      aux.goles += 1;
      jugadores.editPlayer(aux);
      setState(() {
        (equipo == equipo1) ? golE1 += 1 : golE2 += 1;
      });
    }
  }

  void addAmarilla(context, Equipo equipo) async {
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    Jugador aux = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogShowJugadores(
            jugadores: equipo.jugadores,
          );
        });
    if (aux != null) {
      aux.amarillas += 1;
      jugadores.editPlayer(aux);
      setState(() {});
    }
  }

  void addRoja(context, Equipo equipo) async {
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    Jugador aux = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogShowJugadores(
            jugadores: equipo.jugadores,
          );
        });
    if (aux != null) {
      aux.rojas += 1;
      jugadores.editPlayer(aux);
      setState(() {});
    }
  }

  void actualizarEstadisticas() {
    final equipos = Provider.of<EquipoData>(context, listen: false);
    equipo1.partidosJugados += 1;
    equipo2.partidosJugados += 1;
    if (golE1 == golE2) {
      equipo1.puntos += 1;

      equipo2.puntos += 1;
      equipo1.partidosEmpates += 1;
      equipo2.partidosEmpates += 1;
    } else if (golE1 > golE2) {
      equipo1.puntos += 3;
      equipo1.partidosGanados += 1;
      equipo2.partidosPerdidos += 1;
    } else {
      equipo2.puntos += 3;
      equipo2.partidosGanados += 1;
      equipo1.partidosPerdidos += 1;
    }
    equipo1.golesFavor += golE1;
    equipo2.golesFavor += golE2;
    equipo1.golesContra += golE2;
    equipo2.golesContra += golE1;

    equipos.editTeam(equipo1);
    equipos.editTeam(equipo2);
    // equipo1.save();
    // equipo2.save();
  }

  @override
  void initState() {
    print('init state de admin_jugadors: ${widget.partido}');
    if (widget.partido != null) {
      equipo1 = widget.partido.equipo1.first;
      equipo2 = widget.partido.equipo2.first;
      numCancha = widget.partido.numCancha;
      liga = widget.partido.liga;
      fecha = widget.partido.fecha;

      golE1 = widget.partido.golE1;
      golE2 = widget.partido.golE2;
      id = widget.partido.id;
      isFinished = widget.partido.isFinished;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;
    final equiposProvider = Provider.of<EquipoData>(context, listen: false);
    equipos = equiposProvider.getEquipos;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            height: 80,
            child: Row(
              children: [
                Expanded(child: Divider(color: kBordo, thickness: 5)),
                Text('Editar Partido', style: TextStyle(fontSize: 20)),
                Expanded(child: Divider(color: kBordo, thickness: 5)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.45,
                  child: Text(
                    equipo1.nombre,
                    style: kTextStyleBold.copyWith(
                        fontSize: width * 0.05, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: width * 0.45,
                  child: Text(
                    equipo2.nombre,
                    style: kTextStyleBold.copyWith(
                        fontSize: width * 0.05, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$golE1',
                  style: kTextStyleBold.copyWith(
                      fontSize: width * 0.06, color: Colors.black),
                ),
                Text(
                  '$golE2',
                  style: kTextStyleBold.copyWith(
                      fontSize: width * 0.06, color: Colors.black),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Gol',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addGol(context, equipo1);
                      },
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addGol(context, equipo2);
                      },
                    ),
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Gol',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Amarilla',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addAmarilla(context, equipo1);
                      },
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addAmarilla(context, equipo2);
                      },
                    ),
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Amarilla',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Roja',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addRoja(context, equipo1);
                      },
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: kBordo,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        addRoja(context, equipo2);
                      },
                    ),
                    Container(
                      width: width * 0.22,
                      child: Text(
                        'Añadir Roja',
                        style: kTextStyleBold.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * 0.94,
              height: height * 0.06,
              child: FlatButton(
                color: kBordo,
                child: Text(
                  'Finalizar Partido',
                  style: kTextStyle.copyWith(fontSize: width * 0.04),
                ),
                onPressed: () async {
                  var teams = await Hive.openBox<Equipo>(kBoxEquipos);
                  final partidos =
                      Provider.of<PartidoData>(context, listen: false);
                  //TODO: Guardar toda la informaciíon en hive
                  print('Aca se supone que se guarda todo');

                  if (!isFinished) {
                    actualizarEstadisticas();
                    isFinished = true;

                    List<Equipo> aux1 = [];
                    List<Equipo> aux2 = [];
                    aux1.add(equipo1);
                    aux2.add(equipo2);

                    widget.partido.equipo1 = HiveList(teams, objects: aux1);
                    widget.partido.equipo2 = HiveList(teams, objects: aux2);
                    widget.partido.liga = liga;
                    widget.partido.golE1 = golE1;
                    widget.partido.golE2 = golE2;
                    widget.partido.isFinished = isFinished;
                    widget.partido.fecha = fecha;

                    widget.partido.numCancha = numCancha;

                    // widget.partido.save();
                    partidos.editMatch(widget.partido);

                    equiposProvider.editTeam(widget.partido.equipo1.first);
                    equiposProvider.editTeam(widget.partido.equipo2.first);
                  }
                  print('guardando el partido: ${widget.partido.toString()}');

                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
