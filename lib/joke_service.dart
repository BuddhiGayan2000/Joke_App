import 'package:dio/dio.dart';

class JokeService {
  final Dio _dio = Dio();

  Future<String> fetchJoke() async {
    try {
      final response = await _dio.get(
          'https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw'); 

      if (response.statusCode == 200) {
        final jokeData = response.data;
        if (jokeData['type'] == 'twopart') {
          return '${jokeData['setup']} ${jokeData['delivery']}';
        } else if (jokeData['type'] == 'single') {
          return jokeData['joke'];
        } else {
          throw Exception('Invalid joke format');
        }
      } else {
        throw Exception('Failed to fetch joke');
      }
    } catch (e) {
      throw Exception('Error fetching joke: $e');
    }
  }
}
