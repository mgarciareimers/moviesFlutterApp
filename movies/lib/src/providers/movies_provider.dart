import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '139fa8643472e80b9e597a2f165da4e5';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  // Method that gets the movies in cinemas.
  Future<List<Movie>> getMoviesInCinema() async {
    final url = Uri.https(this._url, '/3/movie/now_playing', {
      'api_key' : this._apiKey,
      'language' : this._language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}