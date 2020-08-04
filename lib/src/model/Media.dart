import 'package:movie_app/src/common/util.dart';
import 'package:movie_app/src/common/media_provider.dart';

class Media {
  int id;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overView;
  String releaseDate;
  List<dynamic> genereIds;

  factory Media(Map jsonMap, MediaType mediaType) {
    try {
      return new Media.deserealize(jsonMap, mediaType);
    } catch (e) {
      throw e;
    }
  }

  String getPosterUrl() => getMediumPictureUrl(posterPath);
  String getrBackdropPathUrl() => getLargePictureUrl(posterPath);
  String getGenere() => getGenreValues(genereIds);

  int getReleaseYear() {
    if (releaseDate == null || releaseDate == '') {
      return 0;
    } else {
      return DateTime.parse(releaseDate).year;
    }
  }

  Media.deserealize(Map json, MediaType mediaType)
      : id = json['id'].toInt(),
        voteAverage = json['vote_average'].toDouble(),
        title = json[mediaType == MediaType.movie ? 'title' : 'name'],
        posterPath = json['poster_path'] ?? '',
        backdropPath = json['backdrop_path'] ?? '',
        overView = json['overview'],
        releaseDate = json[
            mediaType == MediaType.movie ? 'release_date' : 'first_air_date'],
        genereIds = json['genre_ids'].toList();
}
