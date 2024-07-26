import 'package:sqflite/sqlite_api.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/business/repositories/bookmark_repository.dart';
import 'package:tt9_quraan_app/features/template/data/datasources/bookmark_local_data_source.dart';
import 'package:tt9_quraan_app/features/template/data/models/bookmark_model.dart';

class BookmarkRepositoryImp extends BookmarkRepository{
  final BookmarkLocalDataSource bookmarkLocalDataSource;

  BookmarkRepositoryImp(this.bookmarkLocalDataSource);

  @override
  Future<List<BookmarkEntity>> bookmarkAya(Database database,BookmarkEntity bookmarkModel) async{
    return  await bookmarkLocalDataSource.bookmarkAya(database, bookmarkModel);
  }

  @override
  Future<List<BookmarkModel>> getBookmarks(Database database) async{
    return await bookmarkLocalDataSource.getBookmarks(database);
  }
}