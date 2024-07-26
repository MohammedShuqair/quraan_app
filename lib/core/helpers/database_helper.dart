import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/alert.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/data/models/bookmark_model.dart';

const String tableName = 'bookmark';
Future<Database> createDatabase(
    BuildContext context, List<String> createQueries) async {
  late Database db;
  await openDatabase('q.db', version: 1, onCreate: (database, version) async {
    print('Database Created');
    for (int i = 0; i < createQueries.length; i++) {
      await database.execute(createQueries[i]).catchError((onError) {
        showSnackBar(context,
            message: 'Error in creation${onError.toString()}');
        // print('Error in creation${onError.toString()}');
      });
    }
    // await database
    //     .execute(
    //     'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)')
    //     .catchError((onError) {
    //   showSnackBar(context,
    //       message: 'Error in creation${onError.toString()}');
    // print('Error in creation${onError.toString()}');
    // });
  }, onOpen: (database) {
    db = database;
  });
  return db;
}

Future<List<BookmarkModel>> insertToDataBase({
  required Database database,
  required BookmarkEntity bookmark,
}) async {
  await database.transaction((txn) async {
    await txn
        .insert(tableName, bookmark.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .catchError((onError) {
      /* showSnackBar(context,
          message: 'Error in inserting New Record ${onError.toString()}');*/
    });
    // await txn
    //     .rawInsert(
    //         'INSERT INTO bookmark(id, suraNo, ayaNo) VALUES($id,$suraNo,$ayaNo)')
  });
  return getBookmarksFromDatabase(database);
}

// Future<List<Bookmark>> deleteFromDatabase(Database database,int id) async {
//   // await database?.rawDelete('DELETE FROM questions WHERE id=$id');
//   await database.delete(tableName, where: 'id=?', whereArgs: [id]);
// }

Future<List<BookmarkModel>> getBookmarksFromDatabase(Database database) async {
  List<Map<String, dynamic>> temp =
      await database.rawQuery('SELECT * FROM $tableName');
  // List<Map<String, dynamic>> temp = await database!.query(tableName);
  return temp.map((e) => BookmarkModel.fromJson(e)).toList();
}
