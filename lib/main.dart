import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/servises/page/page_provider.dart';
import 'package:tt9_quraan_app/servises/provider.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => PageProvider()..createTable(context),
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
            appBarTheme: const AppBarTheme(foregroundColor: Colors.black)),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: LoadingScreen(),
        ));
  }
}
