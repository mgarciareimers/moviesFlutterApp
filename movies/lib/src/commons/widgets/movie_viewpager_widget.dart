import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieViewPager extends StatelessWidget {

  final List<Movie> movies;

  MovieViewPager({ @required this.movies });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        children: this._cards(context),
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
      ),
    );
  }

  // Method that creates the cards of the view pager.
  List<Widget> _cards(BuildContext context) {
    List<Widget> cards = <Widget>[];

    this.movies.forEach((movie) => {
      cards.add(Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160,
                ),
            ),
            SizedBox(height: 5),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ))
    });

    return cards;
  }
}
