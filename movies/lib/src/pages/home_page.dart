import 'package:flutter/material.dart';

import 'package:movies/src/commons/widgets/card_swiper_widget.dart';
import 'package:movies/src/providers/movies_provider.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in Cinemas'),
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            this._swiperCards(),
          ],
        ),
      ),
    );
  }

  // Method that gets the cards for the swiper.
  Widget _swiperCards() {
    return FutureBuilder(
        future: moviesProvider.getMoviesInCinema(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
}
