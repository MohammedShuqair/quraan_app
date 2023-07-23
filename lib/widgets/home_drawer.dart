import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/screens/all_pages.dart';
import 'package:tt9_quraan_app/servises/page/page_provider.dart';

import '../models/juz.dart';
import '../models/page.dart';
import '../screens/part_screen.dart';
import '../shared/functionalty.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.pages,
  });

  final List<QPage> pages;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Juz juz = Juz(
                          juzNo: Juz.quranJuzList[index].juzNo,
                          startPage: Juz.quranJuzList[index].startPage,
                          endPage: Juz.quranJuzList[index].endPage);

                      String part = getJozzName(juz.juzNo);
                      return Consumer<PageProvider>(
                        builder: (context, provider, child) {
                          // PartScreen(
                          //   connectivityResult:
                          //   ConnectivityResult.wifi,
                          //   pages: pages.sublist(
                          //       firstPageNum - 1, lastPageNum),
                          //   partName: part,
                          //   firstPageNum: firstPageNum,
                          //   partNo: juz.juzNo,
                          // )
                          return ListTile(
                            onTap: () {
                              provider.setPageType(juz.juzNo);
                              provider.setSubTitle(part);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                PageProvider()
                                                  ..init(
                                                      context,
                                                      provider.allPages.sublist(
                                                          juz.startPage - 1,
                                                          juz.endPage)),
                                            child: QuranScreen(
                                              pages: provider.allPages.sublist(
                                                  juz.startPage - 1,
                                                  juz.endPage),
                                              isPartScreen: true,
                                            ),
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
    );
  }
}
