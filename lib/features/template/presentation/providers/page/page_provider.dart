import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/template/business/entities/bookmark_entity.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/bookmark_provider.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/page/page_brain.dart';

class PageProvider extends ChangeNotifier {
  PageBrain pageBrain = PageBrain();
  void init(BuildContext context) {
    List<BookmarkEntity> bookmarks =
        Provider.of<BookmarkProvider>(context, listen: false).bookmarks;
    pageBrain.setPageController(
        PageController(initialPage: getBookMark(bookmarks, 0)?.pageNo ?? 0));
    pageBrain.testConnectivity();
    notifyListeners();
  }

  double getProgress() {
    return pageBrain.progress;
  }

  void updateProgress(double progress) {
    pageBrain.updateProgress(progress);
    notifyListeners();
  }

  ConnectivityResult? getConnectivityResult() {
    return pageBrain.connectivityResult;
  }

  PageController getController() {
    return pageBrain.getController();
  }

  BookmarkEntity? getBookMark(List<BookmarkEntity> bookmarks, int by) {
    BookmarkEntity? b;
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

  void animateToBookmark(int pageNo) {
    pageBrain.animateTo(pageNo);
  }

  @override
  void dispose() {
    pageBrain.dispose();
    super.dispose();
  }
}
