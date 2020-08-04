import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Cast.dart';

abstract class ResourceProvider {
  Future<List<Cast>> fetchCasts(int mediaId, MediaType mediaType);
}

abstract class CastsProvider {
  void addCast(Cast cast);
}
