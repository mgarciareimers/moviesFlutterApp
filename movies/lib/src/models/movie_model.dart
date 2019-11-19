class Movie {
  int id;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.id,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.popularity = json['popularity'] / 1;
    this.voteCount = json['vote_count'];
    this.video = json['video'];
    this.posterPath = json['poster_path'];
    this.adult = json['adult'];
    this.backdropPath = json['backdrop_path'];
    this.originalLanguage = json['original_language'];
    this.originalTitle = json['original_title'];
    this.genreIds = json['genre_ids'].cast<int>();
    this.title = json['title'];
    this.voteAverage = json['vote_average'] / 1;
    this.overview = json['overview'];
    this.releaseDate = json['release_date'];
  }

  String getPosterImg() {
    if (this.posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59606710-d544-0136-1d6e-61fd63e82e44/e/0fa64ac0-0314-0137-cf43-1554cd16a871/icons/icon-no-image.svg';
    }

    return 'https://image.tmdb.org/t/p/w500/${this.posterPath}';
  }
}

class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    for (var item in jsonList) {
      this.items.add(new Movie.fromJsonMap(item));
    }
  }
}