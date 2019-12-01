import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/actor_model.dart';

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
                this._createCast(movie),
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
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                height: 150,
              ),
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

  // Method that creates the cast pageView.
  Widget _createCast(Movie movie) {
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movie.id.toString()),
      builder: (BuildContext buildContext, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return this._createCastPageView(snapshot.data);
        }

        return Container(
          height: 400,
          child: Center(
              child: CircularProgressIndicator()
          ),
        );
      },
    );
  }

  // Method that creates the cast page view.
  Widget _createCastPageView(List<Actor> cast) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: cast.length,
        itemBuilder: (BuildContext context, int index) {
          return this._actorCard(cast[index]);
        },
        pageSnapping: false,
      ),
    );
  }

  // Method that creates an actor card.
  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getProfileImg()),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            actor.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
