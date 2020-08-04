import 'package:flutter/material.dart';
import 'package:movie_app/src/media_detail.dart';
import 'package:movie_app/src/model/Media.dart';
import 'package:movie_app/src/media_list_item.dart';
import 'package:movie_app/src/common/media_provider.dart';

class MediaList extends StatefulWidget {
  final MediaProvider provider;
  String category;
  MediaList(this.provider, this.category);

  @override
  _MediaListState createState() => new _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<Media> _media = new List();

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() async {
    var media = await widget.provider.fetchMedia(widget.category);
    setState(() {
      _media.addAll(media);
    });
  }

  @override
  void didUpdateWidget(MediaList oldWidget) {
    if (oldWidget.provider.runtimeType != widget.provider.runtimeType) {
      _media = new List();
      loadMovies();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: _media.length,
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          padding: const EdgeInsets.all(1),
          child: MediaListItem(_media[index]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MediaDetail(_media[index], widget.provider),
              ),
            );
          },
        );
      },
    ));
  }
}
