import 'package:flutter/material.dart';

class PageOption extends StatelessWidget {
  const PageOption(
      {Key? key,
      this.title = 'القرءان الكريم',
      required this.shiftPined,
      required this.isPined,
      required this.animateToBookmark,
      required this.animateToPage,
      required this.progress})
      : super(key: key);
  final String title;
  final VoidCallback shiftPined;
  final void Function() animateToBookmark;
  final void Function(String v) animateToPage;
  final bool isPined;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xfffff7eb),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: shiftPined,
                        icon: Icon(
                          isPined ? Icons.pinch : Icons.pinch_outlined,
                          color: Colors.black,
                        )),
                    Text.rich(TextSpan(
                        style: const TextStyle(fontSize: 10),
                        text: isPined ? "enable" : "disable",
                        children: const [TextSpan(text: " scrolling")]))
                  ],
                ),
                IconButton(
                    onPressed: animateToBookmark,
                    icon: const Icon(
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
                      onSubmitted: animateToPage,
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
            ),
            const SizedBox(
              height: 8,
            ),
            LinearProgressIndicator(
              value: progress,
              color: Colors.brown,
              backgroundColor: Colors.brown.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
