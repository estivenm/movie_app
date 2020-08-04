import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Cast.dart';
import 'package:movie_app/src/resources/api_provider.dart';
import 'package:movie_app/src/resources/db_provider.dart';
import 'package:movie_app/src/resources/resources_provide.dart';

class Repository {
  static final Repository _repository = new Repository();

  ApiProvider _apiProvider = ApiProvider.get();
  DBProvider _dbProvider = DBProvider.get();

  List<ResourceProvider> _provider = <ResourceProvider>[
    dbProvider,
    apiProvider
  ];

  List<CastsProvider> caches = <CastsProvider>[dbProvider];

  static Repository get() {
    return _repository;
  }

  Future<List<Cast>> fetchCastMovies2(int mediaId) async {
    List<Cast> list = await _apiProvider.fetchCreditMovies(mediaId);
    return list;
    // List<Cast> list = await _dbProvider.fetchCasts(mediaId);
    // if (list == null) {
    //   list = await _apiProvider.fetchCreditMovies(mediaId);
    //   list.forEach((item) => _dbProvider.addCast(item));
    //   return list;
    // } else {
    //   return list;
    // }
  }

  Future<List<Cast>> fetchCastShow(int mediaId) async {
    List<Cast> list = await _apiProvider.fetchCreditShows(mediaId);
    return list;
    // List<Cast> list = await _dbProvider.fetchCasts(mediaId);

    // if (list == null) {
    //   list = await _apiProvider.fetchCreditShows(mediaId);
    //   list.forEach((item) => _dbProvider.addCast(item));
    //   return list;
    // } else {
    //   return list;
    // }
  }

  Future<List<Cast>> fetchCasts(int mediaId, MediaType mediaType) async {
    var provider;
    List<Cast> list;

    for (provider in _provider) {
      list = await provider.fetchCasts(mediaId, mediaType);
      if (list != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (cache != provider) {
        list.forEach((item) => _dbProvider.addCast(item));
      }
    }
    return list;
  }
}
