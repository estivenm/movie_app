import 'package:flutter/material.dart';
import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Cast.dart';

class CastScroller extends StatefulWidget {
  final int mediaId;
  final MediaProvider provider;
  CastScroller(this.mediaId, this.provider);

  @override
  _CastScrollerState createState() => new _CastScrollerState();
}

class _CastScrollerState extends State<CastScroller> {
  @override
  void initState() {
    super.initState();
    loadCast();
  }

  final List<Cast> listCast = new List();
  void loadCast() async {
    var result = await widget.provider.fetchCast(widget.mediaId);
    setState(() {
      listCast.addAll(result);
    });
  }

  Widget _builderCast(BuildContext context, int index) {
    var cast = listCast[index];
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 5.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(cast.getCastUrl()),
          ),
          Padding(padding: const EdgeInsets.only(top: 10.0)),
          Text(cast.name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox.fromSize(
          size: const Size.fromHeight(180.0),
          child: ListView.builder(
            itemCount: listCast.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _builderCast,
          ),
        ),
      ],
    );
  }
}
