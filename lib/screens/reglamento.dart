import 'package:flutter/material.dart';
import 'package:la_red/widgets/background_template.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

import '../constants.dart';

class Reglamento extends StatefulWidget {
  @override
  _ReglamentoState createState() => _ReglamentoState();
}

class _ReglamentoState extends State<Reglamento> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  openURLfemenino() async{
    if(await canLaunch("https://drive.google.com/file/d/1SH2JyKG7OJRnHaMr1ilvEFGe-GGZv4Di/view?usp=sharing")){
      await launch("https://drive.google.com/file/d/1SH2JyKG7OJRnHaMr1ilvEFGe-GGZv4Di/view?usp=sharing");
    }else{
      throw 'Could Not Launch URL';
    }
  }
  openURLprotocolo() async{
    if(await canLaunch("https://drive.google.com/file/d/13QPvJnTUafEqArEnbKO5e28kCAuOo8mb/view?usp=sharing")){
      await launch("https://drive.google.com/file/d/13QPvJnTUafEqArEnbKO5e28kCAuOo8mb/view?usp=sharing");
    }else{
      throw 'Could Not Launch URL';
    }
  }
  openURLreglamento() async{
    if(await canLaunch("https://drive.google.com/file/d/1PYHj8oRaGRyqGuyJtOhUkBomN3GuA6MZ/view?usp=sharing")){
      await launch("https://drive.google.com/file/d/1PYHj8oRaGRyqGuyJtOhUkBomN3GuA6MZ/view?usp=sharing");
    }else{
      throw 'Could Not Launch URL';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'reglamento',
        child: Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(45),
              child: Column(
                children: [
                  SizedBox(
                    height: getHeight(0.06),
                  ),

                  MaterialButton(
                    minWidth: getWidth(50),
                    height: getHeight(0.10),
                    onPressed: () {
                      openURLprotocolo();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getWidth(0.07)),
                      //side: BorderSide(color: Colors.black),
                    ),
                    child: Text(
                      "Ver Protocolo COVID-19",
                      style: kTextStyleBold.copyWith(fontSize: getHeight(0.024),color: kBordo),
                    ),
                  ),

                  SizedBox(
                    height: getHeight(0.05),
                  ),

                  MaterialButton(
                    minWidth: getWidth(50),
                    height: getHeight(0.10),
                    onPressed: () {
                      openURLreglamento();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getWidth(0.07)),
                      //side: BorderSide(color: Colors.black),
                    ),
                    child: Text(
                      "Ver Regl. Fut. Masculino",
                      style: kTextStyleBold.copyWith(fontSize: getHeight(0.024),color: kBordo),
                    ),
                  ),

                  SizedBox(
                    height: getHeight(0.05),
                  ),

                  MaterialButton(
                    minWidth: getWidth(50),
                    height: getHeight(0.10),
                    onPressed: () {
                      openURLfemenino();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getWidth(0.07)),
                      side: BorderSide(color: kBordo),
                    ),
                    child: Text(
                      "Ver Regl. Fut. Femenino",
                      style: kTextStyleBold.copyWith(fontSize: getHeight(0.024),color: kBordo),
                    ),
                  ),
                ],


              ),
            ),
          ),
        ),
      ),

    );
  }
}