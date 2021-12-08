import 'dart:ui';

import 'package:bloc_app/src/models/item_model.dart';
import 'package:bloc_app/src/ui/custom_widgets/rating_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatefulWidget {
  AsyncSnapshot<ItemModel> snapshot;
  int index;

  MoviePage(this.snapshot, this.index, {Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Shadow> textShadow = [
    Shadow(
      color: Colors.black,
      offset: Offset(1, 1),
      blurRadius: 0,
    ),
  ];

  _launchURL() async {
    final url =
        'https://www.themoviedb.org/movie/${widget.snapshot.data!.results[widget.index].id.toString()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InteractiveViewer(
        minScale: 0.1,
        maxScale: 1.6,
        child: Stack(children: [
          Image.network(
            'https://image.tmdb.org/t/p/w185${widget.snapshot.data!.results[widget.index].backdrop_path}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            offset: Offset(0, 0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Hero(
                            tag: "poster${widget.index}",
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w185${widget.snapshot.data!.results[widget.index].poster_path}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.snapshot.data!.results[widget.index].title,
                              style: TextStyle(
                                fontSize: 20,
                                shadows: textShadow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(height: 12),
                            Text(
                              widget.snapshot.data!.results[widget.index]
                                  .release_date,
                              style: TextStyle(
                                fontSize: 20,
                                shadows: textShadow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            CustomPaint(
                              foregroundPainter: RatingWidget(),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                      "${(widget.snapshot.data!.results[widget.index].vote_average * 10).toInt().toString()}%"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.snapshot.data!.results[widget.index].overview,
                        style: TextStyle(
                          fontSize: 18,
                          shadows: textShadow,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _launchURL(),
                  child: Container(
                    width: 160,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Watch movie",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.movie,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
