import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/bookmark.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/page/page_brain.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/provider.dart';

class PageProvider extends ChangeNotifier {
  PageBrain pageBrain = PageBrain();
  void init(BuildContext context) {
    List<Bookmark> bookmarks =
        Provider.of<BookmarkProvider>(context, listen: false).bookmarks;
    pageBrain.setPageController(
        PageController(initialPage: getBookMark(bookmarks, 0)?.pageNo ?? 0));
    pageBrain.testConnectivity();
    notifyListeners();
  }

  double getProgress() {
    print("progress is : ${pageBrain.progress}");
    return pageBrain.progress;
  }

  void updateProgress(double progress) {
    pageBrain.progress = progress;
    print("progress is : ${pageBrain.progress}");

    notifyListeners();
  }

  ConnectivityResult? getConnectivityResult() {
    return pageBrain.connectivityResult;
  }

  PageController getController() {
    return pageBrain.getController();
  }

  Bookmark? getBookMark(List<Bookmark> bookmarks, int by) {
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

  void animateToBookmark(int pageNo) {
    pageBrain.animateTo(pageNo);
  }

  @override
  void dispose() {
    pageBrain.dispose();
    super.dispose();
  }
}
