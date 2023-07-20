import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/models/juz.dart';
import 'package:tt9_quraan_app/models/page.dart';
import 'package:tt9_quraan_app/shared/functionalty.dart';
import 'package:tt9_quraan_app/widgets/alert.dart';
import 'package:tt9_quraan_app/widgets/home_app_bar.dart';
import 'package:tt9_quraan_app/widgets/quran_page.dart';

import '../models/aya.dart';
import '../servises/network_connectivity.dart';
import '../widgets/page_body.dart';

class PartScreen extends StatefulWidget {
  const PartScreen(
      {Key? key,
      required this.pages,
      required this.part,
      required this.firstPageNum,
      this.connectivityResult})
      : super(key: key);
  final List<QPage> pages;
  final String part;
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
      child: Scaffold(
        appBar: HomeAppBar(
            progress: /*(_currentPage + 1) / widget.pages.length*/ progress,
            title: widget.part,
            onSubmitted: (textController) {
              int? pageNo = int.tryParse(textController.text);
              if (pageNo != null &&
                  (pageNo >= widget.firstPageNum &&
                      pageNo <=
                          (widget.firstPageNum + widget.pages.length) - 1)) {
                controller.animateToPage(pageNo - widget.firstPageNum,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
                textController.clear();
              } else {
                showSnackBar(context, message: 'الرجاء ادخال ؤقم صحيح');
              }
            },
            onTap: () {
              setState(() {
                isPined = !isPined;
              });
            },
            isPined: isPined),
        body: PageBody(
          controller: controller,
          isPined: isPined,
          pages: widget.pages,
          connectivityResult: widget.connectivityResult,
          firstPageNum: widget.firstPageNum,
          function: (double progress) {
            setState(() {
              this.progress = progress;
            });
          },
        ),
      ),
    );
  }

// int getPreviousIndex() => pageNumber - 1;
}
