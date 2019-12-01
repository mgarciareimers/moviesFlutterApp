import 'package:flutter/material.dart';

import 'package:movies/src/commons/widgets/card_swiper_widget.dart';
import 'package:movies/src/commons/widgets/movie_viewpager_widget.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/commons/utils/search_delegate.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in Cinemas'),
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(), query: '');
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            this._swiperCards(),
            SizedBox(height: 10),
            this._footer(context),
          ],
        ),
      ),
    );
  }

  // Method that gets the cards for the swiper.
  Widget _swiperCards() {
    return FutureBuilder(
        future: moviesProvider.getMoviesInCinema(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(movies: snapshot.data);
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

  // Method that creates a footer.
  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('Popular', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieViewPager(movies: snapshot.data, nextPage: this.moviesProvider.getPopularMovies);
              }

              return Center(
                  child: CircularProgressIndicator(),
              );
            }
          ),
        ],
      ),
    );
  }
}
