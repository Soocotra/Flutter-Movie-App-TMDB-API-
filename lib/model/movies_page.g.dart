// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesPage _$MoviesPageFromJson(Map<String, dynamic> json) => MoviesPage(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['totalResults'] as int?,
    );

Map<String, dynamic> _$MoviesPageToJson(MoviesPage instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => jsonEncode(e)).toList(),
      'totalResults': instance.totalResults,
    };
