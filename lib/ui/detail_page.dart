import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:movie_app/api_config/api_service.dart';
import 'package:movie_app/api_config/config.dart';
import 'package:movie_app/ui/similiar_movie.dart';

class DetailPage extends StatefulWidget {
  final int movieId;

  const DetailPage({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  getMovie(int id) async {
    final movie = await ApiService.getMovie(id: id.toString());
    return movie;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getMovie(widget.movieId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return stackLayout(context, snapshot);
            case ConnectionState.waiting:
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));

            default:
              throw Exception('error');
          }
        },
      ),
    );
  }

  Widget stackLayout(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<String> genres = [];
    for (int i = 0; i < snapshot.data?.genres.length; i++) {
      genres.add(snapshot.data?.genres[i].name);
    }
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: Stack(
        children: [
          Container(
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              '${ApiConfig.imageUrl}${snapshot.data?.poster_path}',
              fit: BoxFit.cover,
            ),
          ),
          detailMovie(context, snapshot, genres)
        ],
      ),
    );
  }

  Widget detailMovie(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      List<String> genres) {
    final DateTime releaseDate = DateTime.parse(snapshot.data?.release_date);
    return Column(
      children: [
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [HexColor('#2C3848'), Colors.transparent],
                    begin: Alignment.center,
                    end: Alignment.topCenter,
                    stops: [0.4, 1])
                .createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
            blendMode: BlendMode.dstIn,
            child: Stack(
              children: [
                Container(
                  color: HexColor('#2C3848'),
                ),
                StretchingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 170.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            posterAndTitle(context, snapshot, genres),
                            dateBar(snapshot, releaseDate),
                            movieOverview(context, snapshot),
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 24),
                                child: Text(
                                  'Similar Movies',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                                height: 330,
                                child:
                                    SimiliarMovies(movieId: snapshot.data?.id)),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox posterAndTitle(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      List<String> genres) {
    return SizedBox(
      height: 223,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '${ApiConfig.imageUrl}${snapshot.data?.poster_path}',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${snapshot.data?.title}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      genres.join(' | '),
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    movieRate(snapshot)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container dateBar(AsyncSnapshot<dynamic> snapshot, DateTime releaseDate) {
    return Container(
      padding: const EdgeInsets.only(top: 40, right: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white))),
            child: Text(
              snapshot.data?.original_language.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              DateFormat.yMMMMd('en_US').format(releaseDate),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ))
        ],
      ),
    );
  }

  Row movieRate(AsyncSnapshot<dynamic> snapshot) {
    return Row(
      children: [
        RatingBar(
          minRating: 1,
          maxRating: 5,
          allowHalfRating: true,
          ignoreGestures: true,
          initialRating: double.parse(
              (snapshot.data?.vote_average / 2).toStringAsFixed(1)),
          itemSize: 16,
          onRatingUpdate: (double value) {},
          ratingWidget: RatingWidget(
            full: Icon(
              Icons.star,
              color: HexColor('#FFF700'),
            ),
            half: Icon(
              Icons.star_half,
              color: HexColor('#FFF700'),
            ),
            empty: const Icon(
              Icons.star,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${(snapshot.data?.vote_average / 2).toStringAsFixed(1)}',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        )
      ],
    );
  }

  Padding movieOverview(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 34, bottom: 24),
            child: Text(
              'StoryBoard',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              snapshot.data?.overview,
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
