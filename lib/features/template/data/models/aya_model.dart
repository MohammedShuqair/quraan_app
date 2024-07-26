import '../../../../../core/constants/constants.dart';
import '../../business/entities/Aya_entity.dart';

class AyaModel extends AyaEntity {
  final int? id;
  final int? lineStart;
  final int? lineEnd;

  AyaModel({
    this.id,
    required int? jozz,
    required int? suraNo,
    required String? suraNameEn,
    required String? suraNameAr,
    required int? page,
    this.lineStart,
    this.lineEnd,
    required int? ayaNo,
    required String? ayaText,
    required String? ayaTextEmlaey,
    required String? ayaTafseer,
    required String? span,
  }) : super(
          jozz: jozz,
          suraNo: suraNo,
          suraNameEn: suraNameEn,
          suraNameAr: suraNameAr,
          page: page,
          ayaNo: ayaNo,
          ayaText: ayaText,
          ayaTextEmlaey: ayaTextEmlaey,
          ayaTafseer: ayaTafseer,
          span: span,
        );
  factory AyaModel.fromJson(Map<String, dynamic> json) {
    bool isString = json[kAyaTafseer] is String;
    return AyaModel(
      id: json[kId],
      jozz: json[kJozz],
      suraNo: json[kSuraNo],
      suraNameEn: json[kSuraNameEn],
      suraNameAr: json[kSuraNameAr],
      page: json[kPage],
      lineStart: json[kLineStart],
      lineEnd: json[kLineEnd],
      ayaNo: json[kAyaNo],
      ayaText: json[kAyaText],
      ayaTextEmlaey: json[kAyaTextEmlaey],
      ayaTafseer: isString ? json[kAyaTafseer] : json[kAyaTafseerText],
      span: isString ? null : json[kAyaTafseerSpan],
    );
  }
}
