import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/business/repositories/bookmark_repository.dart';
import 'package:tt9_quraan_app/features/template/business/usecases/bookmark_aya.dart';
import 'package:tt9_quraan_app/features/template/business/usecases/get_bookmarks.dart';
import 'package:tt9_quraan_app/features/template/data/datasources/bookmark_local_data_source.dart';
import 'package:tt9_quraan_app/features/template/data/repositories/bookmark_repository_imp.dart';

import '../../../../core/helpers/database_helper.dart';

class BookmarkProvider extends ChangeNotifier {
  late Database database;
  static const String tableName = 'bookmark';
  List<BookmarkEntity> bookmarks = [];

  Future<void> createTable(BuildContext context) async {
    database = await createDatabase(context, [
      'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)'
    ]);

    BookmarkRepository repository =
        BookmarkRepositoryImp(BookmarkLocalDataSourceImp());

    bookmarks = await GetBookmarks(repository).call(database);
    notifyListeners();
  }

  Future<void> insertToBookmarks({
    required BookmarkEntity bookmark,
  }) async {
    BookmarkRepository repository =
        BookmarkRepositoryImp(BookmarkLocalDataSourceImp());

    bookmarks = await BookmarkAya(repository).call(database, bookmark);
    notifyListeners();
  }
}
