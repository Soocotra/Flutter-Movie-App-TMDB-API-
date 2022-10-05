import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/api_config/config.dart';
import 'package:movie_app/tools/genre_generator.dart';
import 'package:movie_app/ui/detail_page.dart';
import 'package:movie_app/ui/see_all.dart';
import 'package:skeletons/skeletons.dart';

Widget moviesCard(
    {required AsyncSnapshot<dynamic> movieData,
    required String category,
    required BuildContext context}) {
  return ListView.builder(
    padding: const EdgeInsets.only(left: 24),
    scrollDirection: Axis.horizontal,
    itemCount: movieData.data?.results.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  movieId: movieData.data?.results[index].id,
                ),
              )),
          child: SizedBox(
              width: 185,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    width: 185, height: 250)),
                            imageUrl:
                                '${ApiConfig.imageUrl}${movieData.data?.results[index].poster_path}')),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 7),
                    height: 42,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieData.data?.results[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          GenreGenerator.genreReader(
                              movieData.data?.results[index].genre_ids,
                              movieData.data?.results[index].genre_ids.length),
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      );
    },
  );
}

Widget movieTiles(AsyncSnapshot<dynamic> snapshot, BuildContext context) =>
    ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data?.results.length > 5
          ? 5 + 1
          : snapshot.data?.resulsts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10, left: 24),
          child: index == 5
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeeAll(),
                        ));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ))
              : singleMovieTiles(context, snapshot, index),
        );
      },
    );

ListTile singleMovieTiles(
    BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
  return ListTile(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailPage(movieId: snapshot.data?.results[index].id),
        )),
    visualDensity: const VisualDensity(vertical: 4),
    leading: SizedBox(
      // color: Colors.amber,
      height: 150.73,
      width: 101.21,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: snapshot.data?.results[index].backdrop_path == null
              ? snapshot.data?.results[index].poster_path == null
                  ? 'https://play-lh.googleusercontent.com/XXqfqs9irPSjphsMPcC-c6Q4-FY5cd8klw4IdI2lof_Ie-yXaFirqbNDzK2kJ808WXJk=w240-h480-rw'
                  : '${ApiConfig.imageUrl}${snapshot.data?.results[index].backdrop_path}'
              : '${ApiConfig.imageUrl}${snapshot.data?.results[index].backdrop_path}',
        ),
      ),
    ),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            snapshot.data?.results[index].title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: HexColor('#FFF700'),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${(snapshot.data?.results[index].vote_average / 2).toStringAsFixed(1)}',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    ),
    subtitle: Text(
      GenreGenerator.genreReader(snapshot.data?.results[index].genre_ids,
          snapshot.data?.results[index].genre_ids.length),
      style: const TextStyle(
          fontSize: 11, color: Colors.white, fontWeight: FontWeight.w300),
    ),
  );
}
