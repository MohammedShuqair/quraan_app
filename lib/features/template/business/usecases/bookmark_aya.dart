import 'package:sqflite/sqlite_api.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/business/repositories/bookmark_repository.dart';

class BookmarkAya {
  final BookmarkRepository repository;

  BookmarkAya(this.repository);

  Future<List<BookmarkEntity>> call(
      Database database, BookmarkEntity bookmarkModel) async {
    return await repository.bookmarkAya(database, bookmarkModel);
  }
}
