import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(movies[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            )
          );
        },
        itemCount: 3,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
