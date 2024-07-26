import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/data/models/bookmark_model.dart';

import '../../../../core/helpers/database_helper.dart';

abstract class BookmarkLocalDataSource {
  Future<List<BookmarkEntity>> bookmarkAya(Database database,BookmarkEntity bookmarkModel);
  Future<List<BookmarkModel>> getBookmarks(Database database);
}

class BookmarkLocalDataSourceImp extends BookmarkLocalDataSource {
  @override
  Future<List<BookmarkEntity>> bookmarkAya(
      Database database,BookmarkEntity bookmarkModel) async {
   return await insertToDataBase(database: database, bookmark: bookmarkModel);

  }

  @override
  Future<List<BookmarkModel>> getBookmarks(Database database) async{
    return await getBookmarksFromDatabase(database);
  }
}
