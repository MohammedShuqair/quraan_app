import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/sura.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/home_app_bar.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/page_list.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/page/page_provider.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/provider.dart';

class PartScreen extends StatefulWidget {
  const PartScreen(
      {Key? key,
      required this.pages,
      required this.partName,
      required this.firstPageNum,
      this.connectivityResult,
      required this.partNo})
      : super(key: key);
  final List<List<Sura>> pages;
  final String partName;
  final int partNo;
  final int firstPageNum;
  final ConnectivityResult? connectivityResult;

  @override
  State<PartScreen> createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  bool isPined = false;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    // controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double progress = 0;

  // int _currentPage = 0;
  // void _onPageChanged() {
  //   setState(() {
  //     if (controller.positions.isNotEmpty) {
  //       _currentPage = controller.page?.round() ?? 0;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<PageProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: PageOption(
                title: widget.partName,
                shiftPined: () {},
                isPined: false,
                animateToBookmark: () {},
                animateToPage: (String v) {},
                progress: 0,
              ),
            ),
            body: Consumer<BookmarkProvider>(
              builder: (context, provider, child) {
                return PageList(
                  // controller: controller,
                  // isPined: isPined,
                  pages: widget.pages,
                  // connectivityResult: widget.connectivityResult,
                  firstPageNum: widget.firstPageNum,
                  // function: (double progress) {
                  //   setState(() {
                  //     this.progress = progress;
                  //   });
                  // },
                  isPartScreen: true,
                  bookmark: /*getBookMark(provider.bookmarks, widget.partNo)*/
                      null,
                );
              },
            ),
          );
        },
      ),
    );
  }

// int getPreviousIndex() => pageNumber - 1;
}
