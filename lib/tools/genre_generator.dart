class GenreGenerator {
  static String genreLib(int id) {
    if (id == 28) {
      return 'Action';
    } else if (id == 12) {
      return 'Adventure';
    } else if (id == 16) {
      return 'Animation';
    } else if (id == 35) {
      return 'Comedy';
    } else if (id == 80) {
      return 'Crime';
    } else if (id == 99) {
      return 'Documentary';
    } else if (id == 18) {
      return 'Drama';
    } else if (id == 10751) {
      return 'Family';
    } else if (id == 14) {
      return 'Fantasy';
    } else if (id == 46) {
      return 'History';
    } else if (id == 27) {
      return 'Horror';
    } else if (id == 10402) {
      return 'Music';
    } else if (id == 9648) {
      return 'Mystery';
    } else if (id == 10749) {
      return 'Romance';
    } else if (id == 878) {
      return 'Science Fiction';
    } else if (id == 10770) {
      return 'TV Movie';
    } else if (id == 53) {
      return 'Thriller';
    } else if (id == 10752) {
      return 'War';
    } else if (id == 37) {
      return 'Western';
    }
    return id.toString();
  }

  static String genreReader(List<int> id, int count) {
    List<String> genres = [];
    for (var i = 0; i < count; i++) {
      genres.add(genreLib(id[i]));
    }
    return genres.join(', ');
  }
}
