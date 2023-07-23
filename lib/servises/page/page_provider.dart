import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tt9_quraan_app/models/bookmark.dart';
import 'package:tt9_quraan_app/servises/page/page_brain.dart';
import 'package:tt9_quraan_app/servises/provider.dart';

import '../../models/page.dart';
import '../database_helper.dart';

class PageProvider extends ChangeNotifier {
  late Database database;
  static const String tableName = 'bookmark';
  List<Bookmark> bookmarks = [];
  Future<void> createTable(BuildContext context) async {
    database = await createDatabase(context, [
      'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)'
    ]);
  }

  Future<void> insertToBookmarks(
    BuildContext context, {
    required Bookmark bookmark,
  }) async {
    bookmarks =
        await insertToDataBase(context, database: database, bookmark: bookmark);
    print('list of bookmarks in database$bookmarks');
    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  PageBrain pageBrain = PageBrain();
  List<QPage> allPages = [];
  List<QPage> subPages = [];
  int pageType = 0;
  String title = 'القرءان الكريم';
  void setMainTitle() {
    title = 'القرءان الكريم';
    notifyListeners();
  }

  void setSubTitle(String value) {
    title = value;
    notifyListeners();
  }

  void init(BuildContext context, List<QPage> pages) {
    allPages = pages;
    pageBrain.setPageController(
        PageController(initialPage: getBookmark()?.pageNo ?? 0));
    pageBrain.testConnectivity();
    notifyListeners();
  }

  Bookmark? getBookmark() {
    return _getBookMark(bookmarks, pageType);
  }

  int getPageType() {
    return pageType;
  }

  void setPageType(int value) {
    pageType = value;
  }

  int getPagesLength() {
    return allPages.length;
  }

  double getProgress() {
    return pageBrain.progress;
  }

  void setProgress(double progress) {
    pageBrain.progress = progress;
    notifyListeners();
  }

  ConnectivityResult? getConnectivityResult() {
    return pageBrain.connectivityResult;
  }

  PageController getController() {
    return pageBrain.getController();
  }

  Bookmark? _getBookMark(List<Bookmark> bookmarks, int by) {
    Bookmark? b;
    bookmarks.forEach((element) {
      if (element.id == by) {
        b = element;
      }
    });
    return b;
  }

  void shiftPined() {
    pageBrain.shiftPined();
    notifyListeners();
  }

  bool getPined() {
    return pageBrain.getPined();
  }

  void animateTo(int page) {
    pageBrain.animateTo(page);
  }

  void animateToBookmark(BuildContext context) {
    if (getBookmark() != null) {
      pageBrain.animateTo(getBookmark()!.pageNo);
    }
  }

  @override
  void dispose() {
    pageBrain.dispose();
    super.dispose();
  }
}
