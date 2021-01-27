import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/jugador.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // await readFirestore();
    super.initState();
  }

  void readFirestore() async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference.collection('jugadores').snapshots().listen((event) {
      return event.docs.forEach((element) {
        print(element['nombre']);
      });
    });

    var box = await Hive.openBox<Jugador>(kBoxJugadores);
    // DocumentReference ref = await databaseReference.collection("jugadores").add({
    //   'title': 'Flutter in Action',
    //   'description': 'Complete Programming Guide to learn Flutter'
    // });
    // print(ref.id);

    // var ref.snapshots().map((list) => list.documents.map((doc) => Jugador.fromJson(doc)).toList());

    databaseReference
        .collection("jugadores")
        .get()
        .then((value) => value.docs.forEach((element) {
              print('${element.data()}');
              Jugador aux = Jugador.fromJson(element.data());
              box.add(aux);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
