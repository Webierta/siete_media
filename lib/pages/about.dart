import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              //textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20.0, color: Colors.green[900]),
              child: Column(children: [
                Text('Las Siete y media',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                Text(
                    'Versión 1.2 (Copyleft 2020)\nJesús Cuerda (Webierta)\n'
                    'All Wrongs Reserved.\nLicencia GPLv3.',
                    textAlign: TextAlign.center,
                    style: TextStyle()),
                Divider(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Privacidad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Aplicación gratuita y sin publicidad. No se utiliza ningún dato del usuario. '
                    'Software de código abierto (código fuente en Github), libre de spyware, malware, '
                    'virus o cualquier proceso que atente contra tu dispositivo o viole tu privacidad. '
                    'Esta aplicación no extrae ni almacena ninguna información ni requiere ningún permiso '
                    'extraño, y renuncia a la publicidad y a cualquier mecanismo de seguimiento.\n'),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Licencia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                    'Esta app se comparte libremente bajo las condiciones de la GNU General Public '
                    'License v.3 con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA. '
                    'Este programa es software libre: usted puede redistribuirlo y / o modificarlo '
                    'bajo los términos de la Licencia Pública General GNU publicada por la Fundación '
                    'para el Software Libre, versión 3 (GPLv3). La Licencia Pública General de GNU '
                    'no permite incorporar este programa en programas propietarios.\n'),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Colabora',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Puedes colaborar con el desarrollo de ésta y próximas aplicaciones haciendo '
                    'una pequeña aportación vía PayPal a través de este enlace:\n'),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Image.asset('assets/images/paypal.jpg'),
                  ),
                  onTap: () async {
                    const url =
                        'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=986PSAHLH6N4L';
                    if (kIsWeb) {
                      html.window.open(url, '_blank');
                    } else {
                      if (await canLaunch(url)) {
                        launch(url);
                      }
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reconocimientos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Imágenes baraja: Basquetteur / CC BY-SA (Wikimedia Commons).\n'
                    'Sonidos: Banco de imágenes y sonidos del Instituto de Tecnologías '
                    'Educativas. Ministerio de Educación.'),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
