import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/models/juz.dart';
import 'package:tt9_quraan_app/models/page.dart';
import 'package:tt9_quraan_app/screens/part_screen.dart';
import 'package:tt9_quraan_app/shared/functionalty.dart';
import 'package:tt9_quraan_app/widgets/alert.dart';
import 'package:tt9_quraan_app/widgets/home_app_bar.dart';
import '../servises/network_connectivity.dart';
import '../widgets/page_body.dart';

class AllPagesScreen extends StatefulWidget {
  const AllPagesScreen({Key? key, required this.pages}) : super(key: key);
  final List<QPage> pages;

  @override
  State<AllPagesScreen> createState() => _AllPagesScreenState();
}

class _AllPagesScreenState extends State<AllPagesScreen> {
  bool isPined = false;
  late PageController controller;

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  ConnectivityResult? connectivityResult;
  void testConnectivity() async {
    await _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      setState(() {
        connectivityResult = _source.keys.toList()[0];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
    testConnectivity();
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Container(
          padding: const EdgeInsets.only(top: 24),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffffedd9),
              Color(0xfffff7eb),
              Color(0xfffdfcfa),
            ],
          )),
          child: SafeArea(
            child: Drawer(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 18),
                    child: Text('الأجزاء',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'Al-QuranAlKareem',
                        )),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          int firstPageNum = Juz.quranJuzList[index].startPage;
                          int lastPageNum = Juz.quranJuzList[index].endPage;
                          String part =
                              getJozzName(Juz.quranJuzList[index].juzNo);
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PartScreen(
                                            connectivityResult:
                                                connectivityResult,
                                            pages: widget.pages.sublist(
                                                firstPageNum - 1, lastPageNum),
                                            part: part,
                                            firstPageNum: firstPageNum,
                                          )));
                            },
                            leading: Text(
                              "${Juz.quranJuzList[index].juzNo}",
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                            ),
                            title: Text(
                              part,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 4,
                            ),
                        itemCount: Juz.quranJuzList.length),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: HomeAppBar(
          onSubmitted: (textController) {
            int? pageNo = int.tryParse(textController.text);
            if (pageNo != null &&
                (pageNo >= 1 && pageNo <= widget.pages.length)) {
              controller.animateToPage(pageNo - 1,
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
          isPined: isPined,
          progress: progress,
        ),
        body: PageBody(
          controller: controller,
          isPined: isPined,
          pages: widget.pages,
          connectivityResult: connectivityResult,
          function: (double progress) {
            setState(() {
              print(progress);

              this.progress = progress;
            });
          },
        ),
      ),
    );
  }

  // int getPreviousIndex() => pageNumber - 1;
}
