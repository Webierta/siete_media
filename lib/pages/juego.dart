import 'dart:math';
import 'package:flutter/material.dart';
import 'package:siete_media/data/carta.dart';
import 'package:siete_media/data/user.dart';
import 'package:siete_media/utils/screensize.dart';
import 'package:siete_media/utils/sounds.dart';

class Juego extends StatefulWidget {
  final bool multiplayer;
  final bool mute;

  Juego({Key key, this.multiplayer, this.mute}) : super(key: key);

  @override
  _JuegoState createState() => _JuegoState();
}

class _JuegoState extends State<Juego> {
  Carta carta;
  List<Carta> baraja = Carta.crearBaraja;
  List<Carta> cartasJuego = List<Carta>();
  Image imgCarta;
  String _titulo;
  User jugador = User(Player.Jugador);
  User crupier = User(Player.Crupier);
  User turno;

  @override
  void initState() {
    super.initState();
    if (!widget.mute) Sonido.baraja.audio(); //audio('baraja');
    imgCarta = Image.asset('assets/images/r0.png');
    _titulo = 'Toma una carta del mazo';
    turno = jugador;
  }

  void reset() {
    if (!widget.mute) Sonido.baraja.audio();
    setState(() {
      carta = null;
      imgCarta = Image.asset('assets/images/r0.png');
      baraja = Carta.crearBaraja;
      _titulo = 'Toma una carta del mazo';
      jugador.resetUser();
      crupier.resetUser();
      turno = jugador;
    });
  }

  Carta get sacarCarta {
    if (baraja.length > 0) {
      Carta miCarta = baraja[Random().nextInt(baraja.length)];
      baraja.remove(miCarta);
      turno.cartasUser.add(miCarta);
      if (!widget.mute) Sonido.carta.audio(); // audio('carta');
      return miCarta;
    }
    return Carta('r', 0); //return null;
  }

  nuevaCarta() {
    setState(() {
      carta = sacarCarta;
      imgCarta = carta.imagen;
      turno.puntuacion += carta.valor;
      if (turno.puntuacion > 7.5) {
        if (turno.nombre == Player.Jugador) {
          if (!widget.mute) Sonido.over.audio(); //audio('over');
        } else {
          if (!widget.mute) Sonido.win.audio(); //audio('win');
        }
        turno.pasado = true;
        _titulo = turno.nombre == Player.Jugador
            ? 'Pierdes: Te has pasado'
            : '¡Has ganado!';
      } else {
        _titulo = turno.nombre == Player.Jugador
            ? '¿Carta o te plantas?'
            : 'Turno de la banca';
      }
      //imgCarta = Image.asset('assets/images/${carta.palo}${carta.numero}.png');
      imgCarta = carta.imagen;
    });
  }

  plantar() {
    setState(() {
      if (turno.nombre == Player.Jugador) {
        jugador.plantado = true;
        turno = crupier;
        _titulo = 'Turno de la banca';
        imgCarta = Image.asset('assets/images/r0.png');
      } else {
        crupier.plantado = true;
        if (jugador.puntuacion > crupier.puntuacion) {
          if (!widget.mute) Sonido.win.audio(); // audio('win');
          _titulo = '¡Has ganado!';
        } else {
          if (!widget.mute) Sonido.over.audio(); //audio('over');
          _titulo = '¡La banca gana!';
        }
      }
    });
  }

  solitario() async {
    await Future.delayed(const Duration(seconds: 1));
    nuevaCarta();
    while (crupier.puntuacion < jugador.puntuacion) {
      await Future.delayed(const Duration(seconds: 2));
      nuevaCarta();
    }
    if (crupier.puntuacion <= 7.5) {
      plantar();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double sextoAlto = screenHeight(context, dividedBy: 6);
    //double mitadAncho = screenWidth(context, dividedBy: 2);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(_titulo),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => reset(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  height: sextoAlto * 3,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
                  child: InkWell(
                    child: imgCarta,
                    onTap: ((turno.pasado || turno.plantado) ||
                            (turno.nombre == Player.Crupier &&
                                widget.multiplayer == false))
                        ? null
                        : nuevaCarta,
                  ),
                ),
                Container(
                  height: sextoAlto,
                  child: CartasJugadas(cartasJuego: turno.cartasUser, fila: 0),
                ),
                Container(
                  height: sextoAlto,
                  child: CartasJugadas(cartasJuego: turno.cartasUser, fila: 7),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            height: sextoAlto,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildButton(jugador),
                buildButton(crupier),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildButton(User user) {
    return Container(
      width: screenWidth(context, dividedBy: 3),
      padding: EdgeInsets.all(10.0),
      child: RaisedButton.icon(
        onPressed: ((user.pasado || user.plantado || user.puntuacion == 0.0) ||
                (turno.nombre == Player.Crupier && widget.multiplayer == false))
            ? null
            : () {
                plantar();
                if (turno == crupier && widget.multiplayer == false) {
                  solitario();
                }
              },
        label: Text(
          '${user.puntuacion}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        icon: (() {
          if (turno == user &&
              user.puntuacion == 0.0 &&
              !user.pasado &&
              !user.plantado) return Icon(Icons.lock_open);
          if (user.puntuacion == 0.0) return Icon(Icons.lock);
          if (user.pasado) return Icon(Icons.thumb_down);
          if (user.plantado) return Icon(Icons.thumb_up);
          return Icon(Icons.pan_tool);
        }()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black54),
        ),
        color: Colors.yellow[900],
        textColor: Colors.white,
        disabledColor: (() {
          if (user.puntuacion == 0.0) return Colors.grey;
          if (user.plantado) return Colors.green[900];
          if (user.pasado) return Colors.red[900];
          return Colors.yellow[800];
        }()),
        disabledTextColor:
            user.puntuacion == 0.0 ? Colors.green[900] : Colors.white,
      ),
    );
  }
}

class CartasJugadas extends StatelessWidget {
  const CartasJugadas({
    Key key,
    this.fila,
    this.cartasJuego,
  }) : super(key: key);

  final List<Carta> cartasJuego;
  final int fila;

  filaCartas(int nFila, double ancho) {
    var imgCartas = List<Widget>();
    /* for (var carta in cartasJuego) {
      if (cartasJuego.indexOf(carta) >= nFila && cartasJuego.indexOf(carta) < nFila + 7) {
        imgCartas.add(Image.asset(carta.srcImagen, width: ancho));
      }
    } */
    for (var i = nFila; (i < cartasJuego.length && i < nFila + 7); i++) {
      imgCartas.add(Image.asset(cartasJuego[i].srcImagen, width: ancho));
    }
    return imgCartas;
  }

  @override
  Widget build(BuildContext context) {
    var anchoCarta = screenWidth(context) / 8;
    //var anchoCarta = MediaQuery.of(context).size.width / 8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cartasJuego.isNotEmpty ? filaCartas(fila, anchoCarta) : [],
    );
  }
}
