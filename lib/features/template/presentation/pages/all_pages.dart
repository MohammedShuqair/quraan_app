import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/bookmark_provider.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/page/page_provider.dart';
import 'package:tt9_quraan_app/core/shared/alert.dart';
import 'package:tt9_quraan_app/features/template/presentation/widgets/home_app_bar.dart';
import 'package:tt9_quraan_app/features/template/presentation/widgets/home_drawer.dart';
import 'package:tt9_quraan_app/features/template/presentation/widgets/page_list.dart';

import '../../../../core/shared/functionalty.dart';

class AllPagesScreen extends StatelessWidget {
  const AllPagesScreen({Key? key, required this.pages}) : super(key: key);
  final List<QPage> pages;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer2<PageProvider, BookmarkProvider>(
        builder: (context, provider, bProvider, child) {
          return Scaffold(
            drawer: HomeDrawer(pages: pages),
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 130,
                    backgroundColor: const Color(0xfffff7eb),
                    title: const Text(
                      'القرءان الكريم',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    flexibleSpace: PageOption(
                      shiftPined: provider.shiftPined,
                      isPined: provider.getPined(),
                      animateToBookmark: () => provider.animateToBookmark(
                          getBookMark(bProvider.bookmarks, 0)?.pageNo ?? 0),
                      animateToPage: (v) {
                        int? pageNo = int.tryParse(v);
                        if (pageNo != null &&
                            (pageNo >= 1 && pageNo <= pages.length)) {
                          provider.animateTo(
                            pageNo - 1,
                          );
                        } else {
                          showSnackBar(context,
                              message: 'الرجاء ادخال ؤقم صحيح');
                        }
                      },
                      progress: provider.getProgress(),
                    ),
                  )
                ];
              },
              body: PageList(
                pages: pages,
                bookmark: getBookMark(bProvider.bookmarks, 0),
              ),
            ),
          );
        },
      ),
    );
  }
}
