import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/widgets/quran_page.dart';

import '../models/page.dart';

class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.controller,
    required this.isPined,
    required this.pages,
    required this.connectivityResult,
    this.firstPageNum = 1,
    required this.function,
  });
  final int firstPageNum;
  final PageController controller;
  final bool isPined;
  final List<QPage> pages;
  final ConnectivityResult? connectivityResult;
  final Function(double progress) function;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      physics: isPined ? const NeverScrollableScrollPhysics() : null,
      onPageChanged: (index) {
        function(index / (pages.length - 1));
      },
      itemBuilder: (context, index) {
        return QPageScreen(
          pageNumber: index + firstPageNum,
          page: pages[index].suras,
          connectivityResult: connectivityResult,
        );
      },
      itemCount: pages.length,
    );
  }
}
