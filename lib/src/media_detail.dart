import 'package:flutter/material.dart';
import 'package:movie_app/src/cast_scroller.dart';
import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Media.dart';
import 'dart:ui' as ui;

class MediaDetail extends StatelessWidget {
  final Media media;
  final MediaProvider provider;

  MediaDetail(this.media, this.provider);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            media.getrBackdropPathUrl(),
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 390.0,
                      height: 390.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(media.getPosterUrl()),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            media.title,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'Arvo',
                            ),
                          ),
                        ),
                        Text(
                          '${media.voteAverage.toString()}-10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Arvo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Description
                  Column(children: <Widget>[
                    Text(
                      media.overView.toString(),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontFamily: 'Arvo',
                      ),
                    ),
                  ]),
                  CastScroller(media.id, provider)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
