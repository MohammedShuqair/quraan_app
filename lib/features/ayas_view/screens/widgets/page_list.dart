import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/bookmark.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/sura.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/quran_page.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/page/page_provider.dart';

class PageList extends StatefulWidget {
  const PageList({
    super.key,
    // required this.controller,
    // required this.isPined,
    required this.pages,
    // required this.connectivityResult,
    this.firstPageNum = 1,
    // this.function,
    this.isPartScreen = false,
    this.bookmark,
  });

  final int firstPageNum;
  // final PageController controller;
  // final bool isPined;
  final List<List<Sura>> pages;
  // final ConnectivityResult? connectivityResult;
  // final Function(double progress)? function;
  final bool isPartScreen;
  final Bookmark? bookmark;

  @override
  State<PageList> createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  // late PageController controller;
  //
  // @override
  // void initState() {
  //   controller = PageController(
  //       initialPage:
  //           widget.bookmark == null ? 0 : widget.bookmark?.pageNo ?? 0);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, provider, child) {
        return PageView.builder(
          controller: provider.getController(),
          physics:
              provider.getPined() ? const NeverScrollableScrollPhysics() : null,
          onPageChanged: (index) {
            provider.updateProgress(index / (widget.pages.length - 1));
            // widget.function(index / (widget.pages.length - 1));
          },
          itemBuilder: (context, index) {
            return QPageScreen(
              pageNumber: index + widget.firstPageNum,
              index: index,
              page: widget.pages[index],
              connectivityResult: provider.getConnectivityResult(),
              isPartScreen: widget.isPartScreen,
              bookmark: widget.bookmark,
            );
          },
          itemCount: widget.pages.length,
        );
      },
    );
  }
}
