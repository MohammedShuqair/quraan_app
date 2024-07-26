class AyaEntity {
  final int? jozz;
  final int? suraNo;
  final String? suraNameEn;
  final String? suraNameAr;
  final int? page;
  final int? ayaNo;
  final String? ayaText;
  //to determine which part of aya will viewed on screen
  String? ayaTextView;
  final String? ayaTextEmlaey;
  final String? ayaTafseer;
  final String? span;

  AyaEntity({
    required this.jozz,
    required this.suraNo,
    required this.suraNameEn,
    required this.suraNameAr,
    required this.page,
    required this.ayaNo,
    required this.ayaText,
    required this.ayaTextEmlaey,
    required this.ayaTafseer,
    required this.span,
    this.ayaTextView,
  }) {
    ayaTextView ??= ayaText;
  }

  AyaEntity copyWithAyaTextView(String newAyaTextView) {
    return AyaEntity(
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
        ayaTextView: newAyaTextView);
  }

  //when aya text contain one ore multiply \n divide it to List of aya
  List<AyaEntity> divide() {
    List<AyaEntity> ayaParts = [];
    List<String> ayaPartsString = ayaText?.split("\n") ?? [];
    for (int i = 0; i < ayaPartsString.length; i++) {
      AyaEntity newPart = copyWithAyaTextView(ayaPartsString[i]);
      ayaParts.add(newPart);
    }
    return ayaParts;
  }
}
