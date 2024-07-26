import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt9_quraan_app/features/ayas_view/models/tafseer.dart';
import 'package:tt9_quraan_app/features/ayas_view/models/tafseer_source.dart';
import 'package:tt9_quraan_app/features/ayas_view/screens/widgets/alert.dart';

class Network {
  Future<Map<String, dynamic>> fetchData(int page) async {
    http.Response response = await http.get(
      Uri.parse('http://api.alquran.cloud/v1/page/$page/quran-uthmani'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('error');
  }

  Future<List<TafseerSource>?> fetchTafseerSources() async {
    http.Response response = await http.get(
      Uri.parse('http://api.quran-tafseer.com/tafseer'),
    );
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      List<TafseerSource> list =
          json.map((e) => TafseerSource.fromJson(e)).toList();
      list.forEach((element) {
        print(element.id);
      });

      return list;
    }

    return null;
  }

  Future<Tafseer> fetchTafseer(
      BuildContext context, int soraNo, int ayaNo, int sourceId) async {
    http.Response response = await http.get(
      Uri.parse(
          'http://api.quran-tafseer.com/tafseer/$sourceId/$soraNo/$ayaNo'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      print(json);
      return Tafseer.fromJson(json);
    }

    showSnackBar(context, message: 'خطأ في الاتصال بالانترنت');
    return Future.error('error');
  }
}
