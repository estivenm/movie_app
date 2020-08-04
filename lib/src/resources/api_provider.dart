import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:movie_app/src/common/constant.dart';
import 'package:movie_app/src/model/Media.dart';
import 'dart:convert';
import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Cast.dart';
import 'package:movie_app/src/resources/resources_provide.dart';

class ApiProvider implements ResourceProvider {
  static final _apiProvider = new ApiProvider();

  final String baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';

  static ApiProvider get() {
    return _apiProvider;
  }

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  Future<List<Media>> fetchMovies({String category: 'populares'}) async {
    var uri = new Uri.https(baseUrl, '/3/movie/$category',
        {'api_key': API_KEY, 'page': '1', 'language': _lenguage});

    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.movie))
        .toList()));
  }

  Future<List<Cast>> fetchCreditMovies(int mediaId) async {
    print('${mediaId.toString()} lECTURA  DE tmdb para movies');

    var uri = new Uri.https(baseUrl, '/3/movie/$mediaId/credits',
        {'api_key': API_KEY, 'page': '1', 'language': _lenguage});

    return getJson(uri).then(((data) => data['cast']
        .map<Cast>((item) => new Cast(item, MediaType.movie, mediaId))
        .toList()));
  }

//Programas de television

  Future<List<Media>> fetchShow({String category: 'populares'}) async {
    var uri = new Uri.https(baseUrl, '/3/tv/$category',
        {'api_key': API_KEY, 'page': '1', 'language': _lenguage});

    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.show))
        .toList()));
  }

  Future<List<Cast>> fetchCreditShows(int mediaId) async {
    print('${mediaId.toString()} lECTURA  DE tmdb para show');

    var uri = new Uri.https(baseUrl, '/3/tv/$mediaId/credits',
        {'api_key': API_KEY, 'page': '1', 'language': _lenguage});

    return getJson(uri).then(((data) => data['cast']
        .map<Cast>((item) => new Cast(item, MediaType.show, mediaId))
        .toList()));
  }

  Future<List<Cast>> fetchCasts(int mediaId, MediaType mediaType) async {
    print('${mediaId.toString()} lECTURA  DE tmdb para show');
    final String endPoint = (mediaType == MediaType.movie ? 'movie' : 'tv');

    var uri = new Uri.https(baseUrl, '/3/$endPoint/$mediaId/credits',
        {'api_key': API_KEY, 'page': '1', 'language': _lenguage});

    return getJson(uri).then(((data) => data['cast']
        .map<Cast>((item) => new Cast(item, MediaType.show, mediaId))
        .toList()));
  }
}

final ApiProvider apiProvider = new ApiProvider();
