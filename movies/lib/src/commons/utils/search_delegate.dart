import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';

class DataSearch extends SearchDelegate {

  String selection = '';

  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions of the AppBar.
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icons at the left of the AppBar.
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Creates the results to show.
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: this.moviesProvider.getMoviesQuery(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
            children: movies.map((movie) {
              movie.uniqueId = '${movie.id}-search';

              return ListTile(
                leading: Hero(
                  tag: movie.uniqueId,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movie.getPosterImg()),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  close(context, null);
                  Navigator.pushNamed(context, '/detail', arguments: movie);
                },
              );
            }).toList(),
          );
        }

        return Container(
          height: 400,
          child: Center(
              child: CircularProgressIndicator()
          ),
        );
      }
    );
  }
}