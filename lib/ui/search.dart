import 'package:flutter/material.dart';

import 'package:movie_app/api_config/api_service.dart';
import 'package:movie_app/api_config/config.dart';
import 'package:movie_app/model/movies_page.dart';
import 'package:movie_app/ui/movies_card.dart';
import 'package:movie_app/ui/skeleton_loading.dart';

FutureBuilder<Object?> searchBuilder(String querySearch) => FutureBuilder(
      future: ApiService.getMoviesbyCat('search', querySearch: querySearch),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return snapshot.hasData
                ? movieTiles(snapshot, context)
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: Text(
                        'Find Your Movie',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );

          case ConnectionState.waiting:
            return skeletonTilesLoader();

          default:
            return const Center(
              child: Text("No Data"),
            );
        }
      },
    );

class SearchTextBox extends StatefulWidget {
  final void Function()? onPressed;
  const SearchTextBox({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SearchTextBox> createState() => _SearchTextBoxState();
}

class _SearchTextBoxState extends State<SearchTextBox> {
  String? querySearch;

  @override
  void initState() {
    querySearch = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: widget.onPressed,
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 270,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    querySearch = value.isEmpty
                        ? ''
                        : value.replaceAll(' ', '+').toLowerCase();
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)),
                  filled: true,
                  hoverColor: Colors.white.withOpacity(0.5),
                  isDense: true,
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  hintText: 'Search Movie...',
                  fillColor: Colors.white.withOpacity(0.5),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        querySearch == null
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: Text(
                    'Find Your Movie',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : searchBuilder('$querySearch')
      ],
    );
    ;
  }
}
