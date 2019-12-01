import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor_model.dart';
import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '139fa8643472e80b9e597a2f165da4e5';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularPage = 0;
  bool _isLoading = false;

  List<Movie> _popularMovies = new List();
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => this._popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => this._popularStreamController.stream;

  void disposeStreams() {
    this._popularStreamController?.close();
  }

  // Method that gets the movies in cinemas.
  Future<List<Movie>> getMoviesInCinema() async {
    final url = Uri.https(this._url, '/3/movie/now_playing', {
      'api_key' : this._apiKey,
      'language' : this._language,
    });

    return await this._getData((url));
  }

  // Method that gets the movies in cinemas.
  Future<List<Movie>> getPopularMovies() async {
    if (this._isLoading) {
      return [];
    }

    this._isLoading = true;
    this._popularPage++;

    final url = Uri.https(this._url, '/3/movie/popular', {
      'api_key' : this._apiKey,
      'language' : this._language,
      'page' : this._popularPage.toString(),
    });

    final response = await this._getData((url));

    this._popularMovies.addAll(response);
    this.popularSink(this._popularMovies);

    this._isLoading = false;

    return response;
  }

  // Method that gets data from url.
  Future<List<Movie>> _getData(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.movies;
  }

  // Method that gets the movies in cinemas.
  Future<List<Actor>> getMovieCast(String movieId) async {
    final url = Uri.https(this._url, '/3/movie/$movieId/credits', {
      'api_key' : this._apiKey,
      'language' : this._language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}