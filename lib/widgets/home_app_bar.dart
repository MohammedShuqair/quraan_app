import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar(
      {Key? key,
      required this.onTap,
      required this.isPined,
      required this.onSubmitted,
      this.title = 'القرءان الكريم',
      required this.progress})
      : super(key: key);
  final VoidCallback onTap;
  final bool isPined;
  final ValueChanged<TextEditingController> onSubmitted;
  final String title;
  final double progress;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late TextEditingController controller;
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
    return AppBar(
      backgroundColor: const Color(0xfffff7eb),
      elevation: 0,
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontFamily: 'Al-QuranAlKareem',
        ),
      ),
      actions: [
        IconButton(
            onPressed: widget.onTap,
            icon: Icon(
              widget.isPined ? Icons.pinch : Icons.pinch_outlined,
              color: Colors.black,
            )),
        SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: TextField(
              style:
                  const TextStyle(fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
              controller: controller,
              keyboardType: TextInputType.number,
              onSubmitted: (v) {
                widget.onSubmitted(controller);
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
            value: widget.progress,
            color: Colors.brown,
            backgroundColor: Colors.brown.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
