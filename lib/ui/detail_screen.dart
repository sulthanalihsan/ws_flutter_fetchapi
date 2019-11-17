import 'package:flutter/material.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_item.dart';

class DetailScreen extends StatefulWidget {
  MovieItem movieItem;
  DetailScreen({this.movieItem});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var imageUrl = "http://image.tmdb.org/t/p/w500/";
  var errorImage =
      "https://cdn2.iconfinder.com/data/icons/image-1/64/Image-12-512.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieItem.title),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.movieItem.backdropPath != null
                      ? imageUrl + widget.movieItem.backdropPath
                      : errorImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 10,
                top: 50,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 100,
                    width: 100,
                    child: widget.movieItem.posterPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              imageUrl + widget.movieItem.posterPath,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.network(errorImage)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.movieItem.overview),
          )
        ],
      ),
    );
  }
}
