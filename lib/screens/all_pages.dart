import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/models/page.dart';
import 'package:tt9_quraan_app/servises/provider.dart';
import 'package:tt9_quraan_app/shared/functionalty.dart';
import 'package:tt9_quraan_app/widgets/home_app_bar.dart';
import '../servises/page/page_provider.dart';
import '../widgets/home_drawer.dart';
import '../widgets/page_body.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key, required this.pages, this.isPartScreen = false})
      : super(key: key);
  final List<QPage> pages;
  final bool isPartScreen;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: isPartScreen ? null : HomeDrawer(pages: pages),
        appBar: const HomeAppBar(),
        body: Consumer<PageProvider>(
          builder: (context, provider, child) {
            return PageBody(
              pages: pages,
            );
          },
        ),
      ),
    );
  }
}
