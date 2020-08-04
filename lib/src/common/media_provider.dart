import 'dart:async';
import 'package:movie_app/src/model/Cast.dart';
import 'package:movie_app/src/model/Media.dart';
import 'package:movie_app/src/resources/api_provider.dart';
import 'package:movie_app/src/resources/repository.dart';

abstract class MediaProvider {
  Repository _repository = Repository.get();

  Future<List<Media>> fetchMedia(String category);
  Future<List<Cast>> fetchCast(int mediaId);
}

/// obtener peliculas
class MovieProvider extends MediaProvider {
  ApiProvider _client = ApiProvider.get();

  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    return _repository.fetchCasts(mediaId, MediaType.movie);
  }
}

// obtener programas de televison
class ShowProvider extends MediaProvider {
  ApiProvider _client = ApiProvider.get();

  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchShow(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    return _repository.fetchCasts(mediaId, MediaType.show);
  }
}

enum MediaType { movie, show }
