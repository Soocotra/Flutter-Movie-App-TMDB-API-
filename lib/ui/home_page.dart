import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/api_config/api_service.dart';
import 'package:movie_app/ui/movies_card.dart';
import 'package:movie_app/ui/search.dart';
import 'package:movie_app/ui/skeleton_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;
  final List<String> modalBottomItem = [
    'Now playing',
    'Top Rated',
    'Popular',
    'Trending'
  ];

  late String feature = modalBottomItem[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#198ADF'),
        body: SafeArea(
          child: Column(
            children: [isSearch ? Container() : homeHeader(), mainPage()],
          ),
        ));
  }

  Widget homeHeader() {
    return SizedBox(
        height: 166,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 22, left: 63, right: 93),
              child: Text("Hello, What Do You Want To Discover ?",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  )),
            ),
            searchBar(context)
          ],
        ));
  }

  Padding searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17.0),
      child: Center(
        child: GestureDetector(
          onTap: (() {
            setState(() {
              isSearch = true;
            });
          }),
          child: Container(
            width: 270,
            height: 36,
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              children: const [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 14.8,
                ),
                Text('Search...', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainPage() {
    return Expanded(
        child: AnimatedContainer(
            height: isSearch ? MediaQuery.of(context).size.height : null,
            padding: EdgeInsets.only(
              left: isSearch ? 10 : 24,
              top: 23,
            ),
            decoration: BoxDecoration(
                color: HexColor('#2C3848'),
                borderRadius: isSearch
                    ? null
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
            duration: const Duration(milliseconds: 200),
            child: SingleChildScrollView(
              child: isSearch
                  ? SearchTextBox(
                      onPressed: () {
                        setState(() {
                          isSearch = false;
                        });
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 29.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      elevation: 10,
                                      useSafeArea: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => Wrap(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16, top: 20),
                                                    child: Text(
                                                      'Features',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 7,
                                                            bottom: 50),
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: modalBottomItem
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                  height: 50,
                                                                  child:
                                                                      ListTile(
                                                                    contentPadding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        feature =
                                                                            modalBottomItem[index];
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    title: Text(
                                                                        modalBottomItem[
                                                                            index]),
                                                                  )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      feature,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 330,
                            padding: const EdgeInsets.only(top: 16, bottom: 30),
                            child: moviesBuilder(
                                category: feature, listType: 'listview')),
                        const Padding(
                          padding: EdgeInsets.only(left: 12, top: 10),
                          child: Text(
                            'Upcoming Movies',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: moviesBuilder(
                              category: 'Upcoming',
                              listType: 'tiles',
                            ),
                          ),
                        )
                      ],
                    ),
            )));
  }

  FutureBuilder<Object?> moviesBuilder(
      {required String category,
      required String listType,
      String query = '',
      int page = 0}) {
    return FutureBuilder(
      future: ApiService.getMoviesbyCat(category, querySearch: query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return listType == 'tiles'
                ? skeletonTilesLoader()
                : skeletonCardLoader(movieData: snapshot);
          case ConnectionState.done:
            return listType == 'tiles'
                ? movieTiles(snapshot, context)
                : moviesCard(
                    movieData: snapshot, category: category, context: context);
          default:
            return const Center(
              child: Text("No Data"),
            );
        }
      },
    );
  }
}
