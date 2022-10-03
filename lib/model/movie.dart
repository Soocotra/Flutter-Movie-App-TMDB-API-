import 'package:json_annotation/json_annotation.dart';

import 'package:movie_app/model/genre.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  int? id;
  String? overview;
  double? popularity;
  String? poster_path;
  String? title;
  bool? adult;
  String? backdrop_path;
  Map<String, dynamic>? belongs_to_collection;
  int? budget;
  List<int>? genre_ids;
  String? homepage;
  String? original_language;
  List<Map<String, dynamic>>? production_companies;
  List<Map<String, dynamic>>? production_countries;
  String? release_date;
  int? runtime;
  int? revenue;
  String? status;
  String? tagline;
  bool? video;
  double? vote_average;
  double? vote_count;
  List<Genre>? genres;

  Movie({
    this.id,
    this.overview,
    this.popularity,
    this.poster_path,
    this.title,
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genre_ids,
    this.homepage,
    this.original_language,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.runtime,
    this.revenue,
    this.status,
    this.tagline,
    this.video,
    this.vote_average,
    this.vote_count,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
