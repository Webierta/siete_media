import 'package:flutter/material.dart';

enum Palo { oros, bastos, espadas, copas }

extension PaloExtension on Palo {
  static const palos = {
    Palo.oros: 'oros',
    Palo.bastos: 'bastos',
    Palo.espadas: 'espadas',
    Palo.copas: 'copas'
  };
  String get nombre => palos[this];
  String capital() => nombre[0];
}

class Carta {
  String palo;
  int numero;
  double valor;
  Image imagen;
  String srcImagen;

  //double valorCarta(Carta carta) => carta.numero < 8 ? carta.numero.toDouble() : 0.5;
  double valorCarta(int num) => num < 8 ? num.toDouble() : 0.5;

  Carta(this.palo, this.numero) {
    this.valor = valorCarta(this.numero);
    this.imagen = Image.asset('assets/images/${this.palo}${this.numero}.png');
    this.srcImagen = 'assets/images/${this.palo}${this.numero}.png';
  }

  static List<Carta> get crearBaraja {
    //var palos = ['o', 'b', 'e', 'c'];
    var palos = (Palo.values.map((palo) => palo.capital())).toList();
    var baraja = List<Carta>();
    for (String palo in palos) {
      for (var i = 1; i < 11; i++) {
        baraja.add(Carta(palo, i));
      }
    }
    //palos.forEach((palo) => baraja += List<Carta>.generate(10, (i) => Carta(palo, i + 1)));
    return baraja;
  }
}
