import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

enum Sonido { baraja, carta, tecla, win, over }

extension SoundExtension on Sonido {
  static const files = {
    Sonido.baraja: 'audio/baraja.mp3',
    Sonido.carta: 'audio/carta.mp3',
    Sonido.tecla: 'audio/tecla.mp3',
    Sonido.win: 'audio/win.mp3',
    Sonido.over: 'audio/over.mp3'
  };

  String get file => files[this];

  void audio() async {
    await AudioCache().play(file, mode: PlayerMode.LOW_LATENCY);
  }
}

/* void audio(String sonido) async {
  await AudioCache().play('audio/$sonido.mp3', mode: PlayerMode.LOW_LATENCY);
} */

/* AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
void audio(String sonido) async {
  audioPlayer = await AudioCache().play('audio/$sonido.mp3');
} */
