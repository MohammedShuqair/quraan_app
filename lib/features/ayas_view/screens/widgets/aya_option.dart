import 'package:flutter/material.dart';

class AyaOption extends StatelessWidget {
  const AyaOption({
    Key? key,
    required this.onTapSave,
    this.tafseer,
  }) : super(key: key);
  final void Function() onTapSave;
  final String? tafseer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
                onTap: onTapSave,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bookmark,
                        ),
                        Text('حفظ التقدم')
                      ],
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "التفسير بواسطة : التفسير اليسر",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                tafseer ?? "خطأ في جلب التفسير",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isArabic(String lang) {
    if (lang == "ar") {
      return true;
    } else {
      return false;
    }
  }
}
