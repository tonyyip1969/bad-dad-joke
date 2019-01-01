import 'dart:math';
import 'dart:ui';

class DadTypes {

  String name;
  Color color;

  static const YELLOW = Color(0xfffbed96);
  static const BLUE = Color(0xffabecd6);
  static const BLUE_DEEP = Color(0xffA8CBFD);
  static const BLUE_LIGHT = Color(0xffAED3EA);
  static const PURPLE = Color(0xffccc3fc);
  static const RED = Color(0xffF2A7B3);
  static const GREEN = Color(0xffc7e5b4);
  static const RED_LIGHT = Color(0xffFFC3A0);

  static const List<String> typesOfDad = ['Cranky', 'Angry', 'Hungry', 'Calm', 'Sleepy', 'Corny'];

  static const List<Color> colorsOfDad = [PURPLE, RED, BLUE, GREEN, BLUE_LIGHT, YELLOW];

  static String getType() {
    return typesOfDad[Random().nextInt(typesOfDad.length - 1)];
  }

  DadTypes.random() {
    var idx = Random().nextInt(typesOfDad.length - 1);
    this.name = typesOfDad[idx];
    this.color = colorsOfDad[idx];
  }

}