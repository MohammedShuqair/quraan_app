import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/servises/page/page_provider.dart';

import 'alert.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, provider, child) {
        return AppBar(
          backgroundColor: const Color(0xfffff7eb),
          elevation: 0,
          title: Text(
            provider.title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Al-QuranAlKareem',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  provider.shiftPined();
                },
                icon: Icon(
                  provider.getPined() ? Icons.pinch : Icons.pinch_outlined,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  provider.animateToBookmark(context);
                },
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.black,
                )),
            SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: TextField(
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (v) {
                    int? pageNo = int.tryParse(v);
                    if (pageNo != null &&
                        (pageNo >= 1 && pageNo <= provider.getPagesLength())) {
                      provider.animateTo(
                        pageNo - 1,
                      );
                    } else {
                      showSnackBar(context, message: 'الرجاء ادخال ؤقم صحيح');
                    }
                  },
                  onTapOutside: (p) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                    hintText: 'الذهاب الى',
                  ),
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: LinearProgressIndicator(
                value: provider.getProgress(),
                color: Colors.brown,
                backgroundColor: Colors.brown.withOpacity(0.3),
              ),
            ),
          ),
        );
      },
    );
  }
}
