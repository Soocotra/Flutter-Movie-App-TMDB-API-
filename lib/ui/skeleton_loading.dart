import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget skeletonCardLoader({
  required AsyncSnapshot<dynamic> movieData,
}) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: movieData.data?.results.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SizedBox(
            width: 185,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: const SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 185, height: 230),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 7),
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SkeletonLine(
                        style: SkeletonLineStyle(minLength: 8),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(minLength: 4),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
    },
  );
}

Widget skeletonTilesLoader() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SkeletonListTile(
              hasSubtitle: true,
              hasLeading: true,
              leadingStyle:
                  SkeletonAvatarStyle(borderRadius: BorderRadius.circular(15)),
            ),
          );
        },
      ),
    );
