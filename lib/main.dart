import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(foregroundColor: Colors.black)),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: LoadingScreen(),
      ),
    );
  }
}
