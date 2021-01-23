import 'package:flutter/material.dart';
import 'package:la_red/model/jugador.dart';

import 'package:la_red/constants.dart';

class DialogAddJugadoresToTeam extends StatefulWidget {
  @override
  List<Jugador> jugadores = [];
  DialogAddJugadoresToTeam({this.jugadores});
  _DialogAddJugadoresToTeamState createState() =>
      _DialogAddJugadoresToTeamState();
}

class _DialogAddJugadoresToTeamState extends State<DialogAddJugadoresToTeam> {
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
