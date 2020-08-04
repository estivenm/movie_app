import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/common/util.dart';

class Cast {
  int id;
  String name;
  String profilePath;
  int mediaId;
  String getCastUrl() => getMediumPictureUrl(profilePath);

  factory Cast(Map jsonMap, MediaType mediaType, mediaId) {
    try {
      return new Cast.deserealize(jsonMap, mediaType, mediaId);
    } catch (e) {
      throw e;
    }
  }

  Cast.deserealize(Map jsonMap, MediaType mediaType, mediaId)
      : id = jsonMap['id'].toInt(),
        name = jsonMap['name'],
        profilePath =
            jsonMap['profile_path'] ?? '/eze9FO9VuryXLP0aF2cRqPCcibN.jpg',
        mediaId = mediaId;

  Cast.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'].toInt(),
        name = parsedJson['name'],
        profilePath = parsedJson['profile_path'],
        mediaId = parsedJson['media_Id'].toInt();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "profile_path": profilePath,
      "media_Id": mediaId
    };
  }
}
