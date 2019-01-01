
import 'dart:async';

import 'package:bad_dad_jokes/joke_service.dart';

abstract class BaseBloc {
  void dispose() { }
}

class JokeBloc implements BaseBloc {

  final StreamController<String> _controller = StreamController<String>.broadcast();
  final JokeService service = JokeService();

  Stream<String> get output => _controller.stream;
  Sink<String> get _input => _controller.sink;

  void getRandomJoke() {
    service.getOne().then((data) => _input.add(data));
  }

  @override
  void dispose() {
    _controller.close();
  }

}