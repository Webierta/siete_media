import 'carta.dart';

enum Player { Jugador, Crupier }

class User {
  Player nombre;
  List<Carta> cartasUser; // = List<Carta>();
  double puntuacion;
  bool plantado;
  bool pasado;

  double valorPuntuacion(List<Carta> cartas) {
    double valor = 0.0;
    /* for (Carta carta in cartas) {
      valor += carta.valor;
    } */
    cartas.forEach((c) => valor += c.valor);
    return valor;
  }

  bool isPasado(double punt) {
    return punt > 7.5 ? true : false;
  }

  User(this.nombre) {
    this.cartasUser = List<Carta>();
    this.puntuacion = valorPuntuacion(cartasUser);
    this.plantado = false;
    this.pasado = isPasado(puntuacion);
  }

  resetUser() {
    this.cartasUser.clear();
    this.puntuacion = 0.0;
    this.plantado = false;
    this.pasado = false;
  }
}
