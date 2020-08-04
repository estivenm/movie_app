import 'package:flutter/material.dart';
import 'package:movie_app/src/Media_List.dart';
import 'package:movie_app/src/common/media_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final MediaProvider movieProvider = new MovieProvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;

  Drawer getDrawer(BuildContext context) {
    var header = DrawerHeader(child: Text('Peliculas'));
    var information = AboutListTile(
        child: Text('Información App'),
        applicationIcon: Icon(Icons.favorite),
        applicationVersion: 'V1.0.0.',
        icon: Icon(Icons.info));

    return Drawer(child: getList(header, context, information));
  }

  ListView getList(
      DrawerHeader header, BuildContext context, AboutListTile information) {
    return ListView(
      children: <Widget>[
        header,
        getItem(Icon(Icons.settings), 'Peliculas', '/peliculas', context,
            MediaType.movie),
        getItem(Icon(Icons.live_tv), 'Television', '/television', context,
            MediaType.show),
        getItem(Icon(Icons.close), 'Cerrar', '/', context, null),
        Divider(height: 5.0),
        information
      ],
    );
  }

  ListTile getItem(Icon icon, String description, String routeName,
      BuildContext context, MediaType type) {
    return ListTile(
      selected: type == mediaType,
      leading: icon,
      title: Text(description),
      //Navegación entre rutas
      onTap: () {
        changeMediaType(type);
        // Navigator.pushNamed(context, routeName);
      },
    );
  }

  void changeMediaType(MediaType type) {
    if (type != mediaType) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie
        ? <Widget>[
            new MediaList(movieProvider, 'popular'),
            new MediaList(movieProvider, 'upcoming'),
            new MediaList(movieProvider, 'top_rated')
          ]
        : <Widget>[
            new MediaList(showProvider, 'popular'),
            new MediaList(showProvider, 'on_the_air'),
            new MediaList(showProvider, 'top_rated')
          ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Flutter Movie'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      drawer: getDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: _navigationTapped,
          items: _getFooterItems()),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
        children: _getMediaList(),
      ),
    );
  }

  List<BottomNavigationBarItem> _getFooterItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up), title: Text('Populares')),
      BottomNavigationBarItem(
          icon: Icon(Icons.update),
          title: Text(
              mediaType == MediaType.movie ? 'Proximamente' : 'En el aire')),
      BottomNavigationBarItem(
          icon: Icon(Icons.star), title: Text('Más valoradas'))
    ];
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}
