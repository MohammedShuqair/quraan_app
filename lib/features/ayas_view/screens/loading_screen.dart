import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt9_quraan_app/features/ayas_view/aya_repository/page_repository.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/sura.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/all_pages.dart';
import '../servises/page/page_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  void getAllPage() async {
    List<List<Sura>> pages = await PageRepo().getAllPages();
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        // return MyHomePage(
        //   page: page,
        // );
        return ChangeNotifierProvider(
          create: (BuildContext context) => PageProvider()..init(context),
          child: AllPagesScreen(
            pages: pages,
          ),
        );
      }));
    }
  }

  @override
  void initState() {
    getAllPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
