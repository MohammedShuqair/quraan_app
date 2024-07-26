import 'package:tt9_quraan_app/features/ayas_view/models/aya.dart';

class Sura {
  void setData() {
    if (sura.isNotEmpty) {
      suraNo = sura.first.suraNo;
      suraNameEn = sura.first.suraNameEn;
      suraNameAr = sura.first.suraNameAr;
    }
  }

  List<Aya> sura = [];
  int? suraNo;
  String? suraNameEn;
  String? suraNameAr;

  Sura({this.sura = const [], this.suraNo, this.suraNameEn, this.suraNameAr});
}
