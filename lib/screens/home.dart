import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/models/page.dart';
import 'package:tt9_quraan_app/widgets/home_app_bar.dart';
import 'package:tt9_quraan_app/widgets/quran_page.dart';

import '../models/aya.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.page}) : super(key: key);
  final QPage page;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageNumber = 1;
  List<Sura> page = [];
  bool isPined = false;
  void getData() {
    page = widget.page.suras;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    var controller;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: HomeAppBar(
        //   progress:(controller.page!.round()/widget.pages.length),
        //   onTap: () {
        //     setState(() {
        //       isPined = !isPined;
        //     });
        //   },
        //   isPined: isPined,
        //   onSubmitted: (TextEditingController value) {},
        // ),
        body: SafeArea(
          child: GestureDetector(
            onScaleUpdate: (d) {
              setState(() {
                scale = d.scale;
              });
              print(d.scale);
            },
            child: PageView.builder(
              physics: isPined ? const NeverScrollableScrollPhysics() : null,
              onPageChanged: (index) async {
                if (index > getPreviousIndex()) {
                  pageNumber++;
                } else {
                  pageNumber--;
                }
                await widget.page.getByPage(pageNumber);
                // getData();
                setState(() {});
              },
              itemBuilder: (context, index) {
                return QPageScreen(
                  pageNumber: pageNumber,
                  page: widget.page.suras,
                  // scale: scale,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int getPreviousIndex() => pageNumber - 1;
}
