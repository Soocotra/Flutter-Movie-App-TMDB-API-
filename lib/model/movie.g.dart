// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      poster_path: json['poster_path'] as String?,
      title: json['title'] as String?,
      adult: json['adult'] as bool?,
      backdrop_path: json['backdrop_path'] as String?,
      belongs_to_collection:
          json['belongs_to_collection'] as Map<String, dynamic>?,
      budget: json['budget'] as int?,
      genre_ids:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      homepage: json['homepage'] as String?,
      original_language: json['original_language'] as String?,
      production_companies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      production_countries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      release_date: json['release_date'] as String?,
      runtime: json['runtime'] as int?,
      revenue: json['revenue'] as int?,
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: (json['vote_count'] as num?)?.toDouble(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'title': instance.title,
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'belongs_to_collection': instance.belongs_to_collection,
      'budget': instance.budget,
      'genre_ids': instance.genre_ids,
      'homepage': instance.homepage,
      'original_language': instance.original_language,
      'production_companies': instance.production_companies,
      'production_countries': instance.production_countries,
      'release_date': instance.release_date,
      'runtime': instance.runtime,
      'revenue': instance.revenue,
      'status': instance.status,
      'tagline': instance.tagline,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'genres': instance.genres,
    };
