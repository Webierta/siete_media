import 'package:flutter/material.dart';
import 'package:siete_media/utils/screensize.dart';
import 'package:siete_media/utils/sounds.dart';
import 'about.dart';
import 'info.dart';
import 'juego.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool multiplayer = false;
  bool mute = false;

  @override
  Widget build(BuildContext context) {
    double sextoAlto = screenHeight(context, dividedBy: 6);
    double mitadAncho = screenWidth(context, dividedBy: 2);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Siete y media'),
        actions: [const MenuBotones()],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  height: sextoAlto * 2.5,
                  child: Image.asset(
                    'assets/images/portada.png',
                    //height: quintoAlto * 2.0, // MediaQuery.of(context).size.height / 2.5,
                  ),
                ),
                Container(
                  height: sextoAlto,
                  child: Text(
                    'Las 7 y media',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          color: Colors.green[900],
                          blurRadius: 10.0,
                          offset: Offset(5.0, 5.0),
                        ),
                        Shadow(
                          color: Colors.deepOrange,
                          blurRadius: 10.0,
                          offset: Offset(-5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: sextoAlto * 1.5,
                  child: Column(
                    children: <Widget>[
                      SwitchListTile(
                        dense: true,
                        contentPadding:
                            EdgeInsets.only(left: 60.0, right: 60.0),
                        value: multiplayer,
                        onChanged: (bool valor) {
                          if (!mute) Sonido.tecla.audio(); //audio('tecla');
                          setState(() {
                            multiplayer = valor;
                          });
                        },
                        secondary: multiplayer
                            ? Icon(
                                Icons.people,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                        title: Text(
                          multiplayer ? '2 Jugadores' : 'Contra Android',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        activeColor: Colors.green[900],
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding:
                            EdgeInsets.only(left: 60.0, right: 60.0),
                        value: mute,
                        onChanged: (bool valor) {
                          if (!mute) Sonido.tecla.audio();
                          setState(() {
                            mute = valor;
                          });
                        },
                        secondary: mute
                            ? Icon(
                                Icons.volume_off,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                        title: Text(
                          mute ? 'Sonido Off' : 'Sonido On',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        activeColor: Colors.green[900],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //padding: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green[900],
                child: MaterialButton(
                  minWidth: mitadAncho,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Juego(
                                multiplayer: multiplayer,
                                mute: mute,
                              )),
                    );
                  },
                  child: Text(
                    'JUGAR',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuBotones extends StatelessWidget {
  const MenuBotones({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          buildItemMenu(page: Info(), icono: Icons.info),
          buildItemMenu(page: About(), icono: Icons.code)
        ];
      },
      elevation: 4,
      onSelected: (value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => value),
        );
      },
    );
  }

  PopupMenuItem<Widget> buildItemMenu({Widget page, IconData icono}) {
    return PopupMenuItem(
      value: page,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(icono, color: Colors.green[900]),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(page.toString()),
          ),
        ],
      ),
    );
  }
}
