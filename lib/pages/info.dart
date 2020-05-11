import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  //static const String id = 'info';
  //final String titulo = 'Info';

  //const Info({Key key, String titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 20.0, color: Colors.green[900]),
              child: Column(children: [
                Text('INFO', style: TextStyle(fontSize: 30)),
                Text(
                    '\nEsta App recrea el clásico juego de cartas Las siete y media.\n'),
                Text(
                    'Se juega con una baraja española de 40 cartas (sin 8 ni 9), '
                    'en la que cada carta vale tantos puntos como su valor numérico '
                    'excepto las figuras (sota, caballo y rey), que valen medio punto.\n'),
                Text(
                    'Se juega por turnos contra la banca o entre dos jugadores (el segundo '
                    'jugador actúa como la banca).\n'),
                Text(
                    'Primero un jugador va sacando carta del mazo de la baraja hasta que se '
                    'planta pulsando sobre la puntuación (si no se pasa antes y entonces pierde); '
                    'cuando el primer jugador se planta, empieza el turno del otro jugador o de la banca.\n'),
                Text(
                    'Gana el jugador que más se acerque a 7,5 sin pasarse. En caso de empate, la banca gana.\n'),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
