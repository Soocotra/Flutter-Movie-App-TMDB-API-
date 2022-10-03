import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/movie.dart';

part 'movies_page.g.dart';

@JsonSerializable(explicitToJson: true)
class MoviesPage {
  int? page;
  List<Movie>? results;
  int? totalResults;

  MoviesPage({this.page, this.results, this.totalResults});

  factory MoviesPage.fromJson(Map<String, dynamic> json) =>
      _$MoviesPageFromJson(json);
}
