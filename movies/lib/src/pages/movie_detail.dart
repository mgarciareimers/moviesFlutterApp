import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          this._createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                this._createPosterTitle(context, movie),
                this._createDescription(movie),
              ]
            ),
          ),
        ],
      ),
    );
  }

  // Method that creates a custom appBar.
  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16)
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.getBackdropPathImg()),
          fadeInDuration: Duration(milliseconds: 100),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Method that creates the poster title.
  Widget _createPosterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.amber),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method that creates the description.
  Widget _createDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
