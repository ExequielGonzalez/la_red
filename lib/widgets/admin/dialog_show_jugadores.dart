import 'package:flutter/material.dart';
import 'package:la_red/model/jugador.dart';

import 'package:la_red/constants.dart';

class DialogShowJugadores extends StatefulWidget {
  @override
  List<Jugador> jugadores = [];
  DialogShowJugadores({this.jugadores});
  _DialogShowJugadoresState createState() => _DialogShowJugadoresState();
}

class _DialogShowJugadoresState extends State<DialogShowJugadores> {
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
                    return ListTile(
                      title: Text(
                          '${widget.jugadores[index].nombre} ${widget.jugadores[index].apellido}'),
                      onTap: () {
                        Navigator.of(context).pop(widget.jugadores[index]);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      actions: <Widget>[
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
