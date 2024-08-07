import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/core/shared/functionalty.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/aya.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/juz.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/sura.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/alert.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/page/page_provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
    required this.pages,
  });

  final List<List<Sura>> pages;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  TextEditingController controller = TextEditingController();
  List<Aya> ayas = [];
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: TextField(
                      onSubmitted: (v) {
                        search(context);
                      },
                      style: const TextStyle(
                          fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                      keyboardType: TextInputType.text,
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onTapOutside: (p) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        search(context);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (ayas.isNotEmpty)
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Provider.of<PageProvider>(context, listen: false)
                                  .animateTo(ayas[index].page! - 1);
                            },
                            leading: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                            ),
                            title: Text(
                              ayas[index].ayaTextEmlaey ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                            ),
                            subtitle: Text(
                              '${ayas[index].suraNameAr ?? ''}  الاية رقم ${ayas[index].ayaNo}',
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'Al-QuranAlKareem'),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                      itemCount: ayas.length),
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
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // int firstPageNum = Juz.quranJuzList[index].startPage;
                      // int lastPageNum = Juz.quranJuzList[index].endPage;
                      String part = getJozzName(Juz.quranJuzList[index].juzNo);
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Provider.of<PageProvider>(context, listen: false)
                              .animateTo(Juz.quranJuzList[index].startPage - 1);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => PartScreen(
                          //               connectivityResult:
                          //                   ConnectivityResult.wifi,
                          //               pages: pages.sublist(
                          //                   firstPageNum - 1, lastPageNum),
                          //               partName: part,
                          //               firstPageNum: firstPageNum,
                          //               partNo: Juz.quranJuzList[index].juzNo,
                          //             )));
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
                    itemCount: Juz.quranJuzList.length)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search(BuildContext context) {
    widget.pages.forEach((page) {
      page.forEach((sura) {
        sura.sura.forEach((aya) {
          if (aya.ayaTextEmlaey
                  ?.toLowerCase()
                  .contains(controller.text.toLowerCase()) ??
              false) {
            setState(() {
              ayas.add(aya);
            });
          }
        });
      });
    });
    if (ayas.isEmpty) {
      showSnackBar(context, message: 'الرجاء ادخال اية صحيحة');
    }
  }
}
