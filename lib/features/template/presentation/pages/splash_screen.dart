import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/core/paints/ZegZagBorder.dart';
import 'package:tt9_quraan_app/features/template/presentation/pages/all_pages.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/page/page_provider.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/quran_pages_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          QuranPagesProvider()..eitherFailureOrQuranPages(),
      child: SafeArea(
        child: Scaffold(
          body: Selector<QuranPagesProvider, List<QPage>?>(
            selector: (context, provider) => provider.quranPages,
            builder: (context, value, child) {
              if (value == null) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: ZegZagBorder(),
                  child: Center(
                    child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                      TyperAnimatedText("القرآن الكريم",
                          speed: const Duration(milliseconds: 100),
                          textStyle: const TextStyle(
                              fontSize: 34, fontWeight: FontWeight.w500))
                    ]),
                  ),
                );
              } else {
                return ChangeNotifierProvider(
                  create: (BuildContext context) =>
                      PageProvider()..init(context),
                  child: AllPagesScreen(pages: value),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
