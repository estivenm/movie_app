import 'package:movie_app/src/common/media_provider.dart';
import 'package:movie_app/src/model/Cast.dart';
import 'package:movie_app/src/resources/resources_provide.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBProvider implements ResourceProvider, CastsProvider {
  static final DBProvider _dbProvider = new DBProvider();
  Database db;

  DBProvider() {
    init();
  }

  static DBProvider get() {
    return _dbProvider;
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "Casts4.db");
    db = await openDatabase('my_db.db', version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(""" 
          CREATE TABLE Casts
          (
            id INTEGER PRIMARY KEY,
            name TEXT,
            profile_path TEXT,
            media_Id INTEGER
          )
        """);
    });
    print('BD INICIALIZADA');
  }

  Future<List<Cast>> fetchCasts(int mediaId, MediaType mediaType) async {
    print('${mediaId.toString()} Lectura de Base de datos Local');
    var maps = await db.query(
      "Casts",
      columns: null,
      where: "media_Id = ?",
      whereArgs: [mediaId],
    );
    if (maps.length > 0) {
      return maps.map<Cast>((item) => new Cast.fromDb(item)).toList();
    }

    return null;
  }

  void addCast(Cast cast) {
    print('${cast.mediaId.toString()} Insertar en Base de datos Local');
    db.insert("Casts", cast.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

final DBProvider dbProvider = new DBProvider();
