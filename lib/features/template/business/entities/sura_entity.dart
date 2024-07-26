import 'package:tt9_quraan_app/core/constants/constants.dart';
import 'package:tt9_quraan_app/features/template/business/entities/Aya_entity.dart';

class SuraEntity {
  void setData() {
    if (sura.isNotEmpty) {
      suraNo = sura.first.suraNo;
      suraNameEn = sura.first.suraNameEn;
      suraNameAr = sura.first.suraNameAr;
    }
  }

  List<SuraLine> sura = [];
  int? suraNo;
  String? suraNameEn;
  String? suraNameAr;

  SuraEntity(
      {this.sura = const [], this.suraNo, this.suraNameEn, this.suraNameAr});
}
