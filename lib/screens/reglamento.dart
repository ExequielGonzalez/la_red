import 'package:flutter/material.dart';
import 'package:la_red/widgets/background_template.dart';

class Reglamento extends StatefulWidget {
  @override
  _ReglamentoState createState() => _ReglamentoState();
}

class _ReglamentoState extends State<Reglamento> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'reglamento',
        child: Container(
          height: getHeight(0.60),
          width: getWidth(0.85),   //
          margin: EdgeInsets.only(
              left: getWidth(0.056),  //
              right: getWidth(0.056),  //
              top: getHeight(0.029),  //
              ),

          child: Scaffold(

            body: ListView(

              children: [Text(" Al día de la fecha, las comunicaciones son una parte fundamental de nuestras vidas, en este trabajo realzaremos un breve resumen de las actuales tecnologías de telefonía móvil  para luego investigar y documentar en que se basa la Tecnología 5G, las mejoras que propone y también realizar un resumen de las pruebas echas hasta el momento en Argentina.Además, uno de los beneficios que esta nueva tecnología nos promete es la de dar mayor soporte y confiabilidad al IoT (Internet of Things) por lo cual realizaremos también un apartado especial para dicho tema y como se vinculan "
            "éstas tecnologías La telefonía celular debe su nombre a la forma en que se divide el área de servicio del operador en una serie de hexágonos que, al ser unidos entre sí, forman una figura de celdas similar a un panal. En cada celda hay una estación base que cuenta con un transmisor y un receptor de radio de baja potencia. Cada estación cubre una determinada área geográfica. La unión de varias de ellas forma la red celular, a través de la cual se pueden establecer comunicaciones no sólo con abonados del servicio celular, sino también con aquellos que emplean la telefonía convencional. La formación de un sistema de células o una red depende, entre otros factores, de la topografía, la potencia de los transmisores y de la cantidad de tráfico (número de llamadas) que vayan a soportar las células. A medida que la distancia entre las estaciones base y la móvil se incrementa, la señal se puede deteriorar."

          ),],
            )
          ),
        ),
    ),
    );
  }
}