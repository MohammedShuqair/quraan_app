import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/data/models/bookmark_model.dart';

abstract class BookmarkRepository {
  Future<List<BookmarkEntity>> bookmarkAya(Database database,BookmarkEntity bookmarkModel);
  Future<List<BookmarkModel>> getBookmarks(Database database,);
}