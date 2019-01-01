import 'dart:async';
import 'dart:convert' show json;
import 'package:bad_dad_jokes/joke.dart';
import 'package:http/http.dart' as http;

// {
//   "id": "RZv4h3gV0g",
//   "joke": "Is the pool safe for diving? It deep ends.",
//   "status": 200
// }

class JokeService {

  final String _apiUrl = 'https://icanhazdadjoke.com/';
  final _headers = {"Accept": "application/json"};

  Future<JokeModel> getOne() async {
    JokeModel joke;
    await http.get(_apiUrl, headers: _headers).then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        var jokeData = json.decode(data.body)['joke'];

        joke = JokeModel(jokeData);
      }
    });
    return joke;
  }
}