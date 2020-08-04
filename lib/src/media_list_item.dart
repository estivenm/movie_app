import 'package:flutter/material.dart';
import 'package:movie_app/src/model/Media.dart';

class MediaListItem extends StatelessWidget {
  final Media media;

  MediaListItem(this.media);
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: Column(
      children: <Widget>[
        Container(
          child: Stack(children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
              image: media.getrBackdropPathUrl(),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 40),
              height: 340.0,
              width: double.infinity,
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900].withOpacity(0.5),
                ),
                constraints: BoxConstraints.expand(height: 55.0),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 325.0,
                    child: Text(
                      media.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      media.getGenere(),
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 10.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(media.voteAverage.toString()),
                        Container(width: 4.0),
                        Icon(Icons.stars, color: Colors.white, size: 16.0),
                        Container(
                          width: 4.0,
                        ),
                      ],
                    ),
                    Container(width: 4.0),
                    Row(
                      children: <Widget>[
                        Text(media.getReleaseYear().toString()),
                        Container(width: 4.0),
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ],
                    )
                  ],
                )),
          ]),
        ),
      ],
    ));
  }
}
