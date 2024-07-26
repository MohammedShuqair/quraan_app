import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/features/template/business/repositories/bookmark_repository.dart';
import 'package:tt9_quraan_app/features/template/data/models/bookmark_model.dart';

class GetBookmarks {
  final BookmarkRepository repository;

  GetBookmarks(this.repository);

  Future<List<BookmarkModel>> call(Database database) async {
   return await repository.getBookmarks(database);
  }
}