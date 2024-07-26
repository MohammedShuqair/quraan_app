import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/template/presentation/pages/splash_screen.dart';
import 'package:tt9_quraan_app/features/template/presentation/providers/bookmark_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) =>
            BookmarkProvider()..createTable(context),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "UthmanverHafs",
            appBarTheme: const AppBarTheme(foregroundColor: Colors.black)),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: SplashScreen(),
        ));
  }
}
