import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/models/tafseer_source.dart';
import 'package:tt9_quraan_app/widgets/alert.dart';

import '../models/aya.dart';
import '../models/page.dart';
import '../models/tafseer.dart';
import '../servises/network.dart';
import '../shared/functionalty.dart';

class QPageScreen extends StatefulWidget {
  const QPageScreen({
    super.key,
    required this.pageNumber,
    required this.page,
    this.connectivityResult,
    // required this.scale,
  });
  final ConnectivityResult? connectivityResult;
  final int pageNumber;
  final List<Sura> page;

  // final double scale;

  @override
  State<QPageScreen> createState() => _QPageScreenState();
}

class _QPageScreenState extends State<QPageScreen> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (d) {
        setState(() {
          scale = d.scale;
        });
        print(d.scale);
      },
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
                          fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                    ),
                    const Spacer(),
                    for (int i = 0; i < widget.page.length; i++) ...{
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8),
                        child: Text(
                          widget.page[i].suraNameAr ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
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
                    child: Text.rich(
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
                                      margin: const EdgeInsets.only(bottom: 8),
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
                                            fontFamily: 'Al-QuranAlKareem'),
                                      ),
                                    ),
                                    Visibility(
                                        visible: widget
                                                    .page[i].sura[j].suraNo !=
                                                1 &&
                                            widget.page[i].sura[j].suraNo != 9,
                                        child: const Text(
                                          'بسم الله الرحمن الرحيم',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontFamily: 'HafsSmart'),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            TextSpan(
                                recognizer: LongPressGestureRecognizer(
                                  duration: const Duration(milliseconds: 200),
                                )..onLongPress = () => onLongPress(
                                    context,
                                    widget.page[i].sura[j].suraNo ?? 1,
                                    widget.page[i].sura[j].ayaNo ?? 1),
                                text: ' ${widget.page[i].sura[j].ayaText} ',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'HafsSmart')),
                          },
                        ],
                      ),
                      textAlign: TextAlign.center,
                      textScaleFactor: scale,
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

  void onLongPress(
    BuildContext context,
    int soraNo,
    int ayaNo,
  ) async {
    if (widget.connectivityResult == ConnectivityResult.mobile ||
        widget.connectivityResult == ConnectivityResult.wifi ||
        widget.connectivityResult == ConnectivityResult.ethernet) {
      // List<TafseerSource> sources =
      //     await Network().fetchTafseerSources(context);
      Tafseer tafseer = await Network().fetchTafseer(context, soraNo, ayaNo);

      if (mounted) {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            builder: (context) {
              return Container(
                  padding: const EdgeInsets.all(16),
                  // height: 300,
                  child: Text(
                    '${tafseer.text}',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ));
            });
      }
    } else {
      showSnackBar(context,
          message: 'الرجاء الاتصال بالانترنت لتفعيل ميزة التفسير');
    }
  }
}
