import 'package:json_annotation/json_annotation.dart';

part 'movie_item.g.dart';

// poster_path: "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
// backdrop_path: "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
// original_title: "Joker",
// title: "Joker",
// overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
// release_date: "2019-10-02"

@JsonSerializable()
class MovieItem {
  @JsonKey(name: 'poster_path')
  String posterPath;

  @JsonKey(name: 'backdrop_path')
  String backdropPath;

  @JsonKey(name: 'original_title')
  String originalTitle;

  String title;

  String overview;

  @JsonKey(name: "release_date")
  String releaseDate;

  MovieItem(
      {this.posterPath,
      this.backdropPath,
      this.originalTitle,
      this.title,
      this.overview,
      this.releaseDate});

  factory MovieItem.fromJson(Map<String, dynamic> json) => _$MovieItemFromJson(json);
  Map<String, dynamic> toJson() => _$MovieItemToJson(this);
}
