import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieViewPager extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieViewPager({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    this._pageController.addListener(() {
      if (this._pageController.position.pixels >= this._pageController.position.maxScrollExtent - 200) {
        this.nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) => this._createCard(context, movies[index]),
        pageSnapping: false,
        controller: this._pageController
      ),
    );
  }

  // Method that creates a card.
  Widget _createCard(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';

    final card = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      )
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: movie);
      },
    );
  }

  // Method that creates the cards of the view pager. - Not used because PageView.builder is used instead of PageView.
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
