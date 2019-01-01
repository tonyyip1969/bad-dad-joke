import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

// {
//   "id": "RZv4h3gV0g",
//   "joke": "Is the pool safe for diving? It deep ends.",
//   "status": 200
// }

class JokeService {

  final String _apiUrl = 'https://icanhazdadjoke.com/';
  final _headers = {"Accept": "application/json"};

  Future<String> getOne() async {
    String jokeData;
    await http.get(_apiUrl, headers: _headers).then((joke) {
      if (joke.statusCode == 200) {
        print(joke.body);
        jokeData = json.decode(joke.body)['joke'];
      }
    });
    return jokeData;
  }
}