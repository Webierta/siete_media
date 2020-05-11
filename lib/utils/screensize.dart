import 'package:flutter/material.dart';

// tamaño de la pantalla
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

// alto de la barra de estado
double statusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

// alto de la pantalla (sin contar las barras de herramientas ni de estado)
// para repartir entre distintos elementos
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return (screenSize(context).height - kToolbarHeight - statusBarHeight(context)) / dividedBy;
}

// ancho de la pantalla
// para repartir entre distintos elementos
double screenWidth(BuildContext context, {double dividedBy = 1, int divideBy}) {
  return screenSize(context).width / dividedBy;
}
