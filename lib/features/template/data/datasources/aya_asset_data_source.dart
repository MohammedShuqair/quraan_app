import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/core/errors/exceptions.dart';
import 'package:xml/xml.dart';
import '../models/Aya_model.dart';

abstract class AyaAssetDataSource {
  Future<List<AyaModel>> getAyas();
}

class AyaAssetDataSourceImpl implements AyaAssetDataSource {
  AyaAssetDataSourceImpl();

  @override
  Future<List<AyaModel>> getAyas() async {
    String result = await rootBundle.loadString(kQuranPath);
    if (result.isNotEmpty) {
      List<dynamic> ayahs = jsonDecode(result)["DATA"]["ROW"];
      return ayahs.map((e) => AyaModel.fromJson(e)).toList();
    } else {
      throw AssetException(
          "خطأ في تحميل ملف القران الكريم الرجاء اعادة تثبيت التطبيق");
    }
  }
  // @override
  // Future<List<AyaModel>> getAyas() async {
  //   String result = await rootBundle.loadString(kQuranPath);
  //   if (result.isNotEmpty) {
  //     XmlDocument xml = XmlDocument.parse(result);
  //     xml.findAllElements("")
  //   } else {
  //     throw AssetException(
  //         "خطأ في تحميل ملف القران الكريم الرجاء اعادة تثبيت التطبيق");
  //   }
  // }
}
