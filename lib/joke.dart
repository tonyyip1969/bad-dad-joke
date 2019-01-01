import 'dart:ui';

import 'package:bad_dad_jokes/dad_types.dart';

class JokeModel {
  String text;
  Color backgroundColor;
  String type;

  JokeModel(String _text) {
    text = _text;
    var dadTypes = DadTypes.random();
    backgroundColor = dadTypes.color;
    type = dadTypes.name;
  }

}