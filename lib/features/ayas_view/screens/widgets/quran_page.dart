import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/core/shared/functionalty.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/aya.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/bookmark.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/aya_option.dart';
import 'package:tt9_quraan_app/features/ayas_view/servises/provider.dart';

import '../../models/sura.dart';

class QPageScreen extends StatefulWidget {
  const QPageScreen({
    super.key,
    required this.pageNumber,
    required this.page,
    this.connectivityResult,
    this.bookmark,
    this.isPartScreen = false,
    required this.index,
    // required this.scale,
  });

  final ConnectivityResult? connectivityResult;
  final int pageNumber;
  final int index;
  final List<Sura> page;
  final Bookmark? bookmark;
  final bool isPartScreen;

  // final double scale;

  @override
  State<QPageScreen> createState() => _QPageScreenState();
}

class _QPageScreenState extends State<QPageScreen> {
  bool isMarked(Bookmark? bookmark, int suraNo, int ayaNo) {
    if (bookmark != null &&
        bookmark.suraNo == suraNo &&
        bookmark.ayaNo == ayaNo) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    /*GestureDetector(
        onScaleUpdate: (d) {
          setState(() {
            scale = d.scale;
          });
        },*/
    return InteractiveViewer(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: widget.pageNumber % 2 == 0
              ? const LinearGradient(
                  colors: [
                    Color(0xffffedd9),
                    Color(0xfffff7eb),
                    Color(0xfffdfcfa),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xfffdfcfa),
                    Color(0xfffff7eb),
                    Color(0xffffedd9),
                  ],
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      getJozzName(widget.page.first.sura.first.jozz ?? 0),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    for (int i = 0; i < widget.page.length; i++) ...{
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8),
                        child: Text(
                          widget.page[i].suraNameAr ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    }
                  ],
                ),
                for (int i = 0; i < widget.page.length; i++) ...{
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Consumer<BookmarkProvider>(
                      builder: (context, provider, child) {
                        return Text.rich(
                          TextSpan(
                            children: [
                              for (int j = 0;
                                  j < widget.page[i].sura.length;
                                  j++) ...{
                                WidgetSpan(
                                  child: Visibility(
                                    visible: widget.page[i].sura[j].ayaNo == 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          height: 60,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'images/head_of_surah.png',
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            widget.page[i].suraNameAr ?? '',
                                            style: const TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: widget.page[i].sura[j]
                                                        .suraNo !=
                                                    1 &&
                                                widget.page[i].sura[j].suraNo !=
                                                    9,
                                            child: const Text(
                                              'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيم',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                TextSpan(
                                    recognizer: TapGestureRecognizer(
                                        /*duration:
                                          const Duration(milliseconds: 200),*/
                                        )
                                      ..onTap = () {
                                        Aya aya = widget.page[i].sura[j];
                                        onPressAya(context, provider,
                                            bookmark: Bookmark(
                                                widget.isPartScreen
                                                    ? aya.jozz ?? 0
                                                    : 0,
                                                widget.index,
                                                aya.suraNo ?? 1,
                                                aya.ayaNo ?? 1),
                                            tafsser: aya.ayaTafseer);
                                      },
                                    text: ' ${widget.page[i].sura[j].ayaText} ',
                                    style: TextStyle(
                                      backgroundColor: isMarked(
                                              /*getBookMark(
                                                  provider.bookmarks, 0)*/
                                              null,
                                              widget.page[i].sura[j].suraNo ??
                                                  1,
                                              widget.page[i].sura[j].ayaNo ?? 1)
                                          ? Colors.brown.withOpacity(0.5)
                                          : null,
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              },
                            ],
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                },
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.pageNumber.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressAya(
    BuildContext context,
    BookmarkProvider provider, {
    required Bookmark bookmark,
    required String? tafsser,
  }) async {
    print('book mark $bookmark');
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return AyaOption(
            onTapSave: () {
              provider.insertToBookmarks(context, bookmark: bookmark);
            },
            tafseer: tafsser,
          );
        });
  }

/*  Widget tafseerBody(
    int soraNo,
    int ayaNo,
  ) {
    if (widget.connectivityResult == ConnectivityResult.mobile ||
        widget.connectivityResult == ConnectivityResult.wifi ||
        widget.connectivityResult == ConnectivityResult.ethernet) {
      Future<Tafseer> tafseer =
          Network().fetchTafseer(context, soraNo, ayaNo, currentSource);
      // List<TafseerSource> sources =
      //     await Network().fetchTafseerSources(context);
      return FutureBuilder<Tafseer>(
          future: tafseer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              String tbody = snapshot.data?.text ?? "الرجاء لانتظار";
              return Container(
                  padding: const EdgeInsets.all(16),
                  // height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${snapshot.data?.tafseerName}:",
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        tbody,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return const SizedBox();
    }
  }*/
}
