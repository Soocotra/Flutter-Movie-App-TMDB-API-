import 'package:dio/dio.dart';
import 'package:movie_app/api_config/config.dart';
import 'package:movie_app/model/movies_page.dart';
import '../model/movie.dart';

abstract class ApiService {
  static Future<MoviesPage?> getMovies(
      {required String path, int page = 1, String querySearch = ''}) async {
    try {
      String url;
      url = querySearch == ''
          ? '${ApiConfig.url}$path${ApiConfig.api}&${ApiConfig.queryPage}$page'
          : '${ApiConfig.url}$path${ApiConfig.api}&${ApiConfig.queryPage}$page&${ApiConfig.querySearch}$querySearch';

      var response = await Dio().get(url);
      return MoviesPage.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Movie> getMovie({required String id}) async {
    try {
      String url = '${ApiConfig.url}movie/$id${ApiConfig.api}';

      var res = await Dio().get(url);
      return Movie.fromJson(res.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static getMoviesbyCat(String category,
      {int id = 0, int page = 1, String querySearch = ''}) async {
    MoviesPage? moviesPage;
    if (category == 'Trending') {
      moviesPage = await getMovies(path: 'trending/movie/week', page: page);
    } else if (category == 'Popular') {
      moviesPage = await getMovies(path: 'movie/popular', page: page);
    } else if (category == 'Now playing') {
      moviesPage = await getMovies(path: 'movie/now_playing', page: page);
    } else if (category == 'similiar') {
      moviesPage = await getMovies(path: 'movie/$id/similar', page: page);
    } else if (category == 'Upcoming') {
      moviesPage = await getMovies(path: 'movie/upcoming', page: page);
    } else if (category == 'Top Rated') {
      moviesPage = await getMovies(path: 'movie/top_rated');
    } else if (category == 'search') {
      moviesPage =
          await getMovies(path: 'search/movie', querySearch: querySearch);
    }

    return moviesPage;
  }
}
