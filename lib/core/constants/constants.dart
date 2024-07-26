import 'package:tt9_quraan_app/features/template/business/entities/Aya_entity.dart';
import 'package:tt9_quraan_app/features/template/business/entities/sura_entity.dart';

typedef QPage = List<SuraEntity>;
typedef SuraLine = List<AyaEntity>;

const String kQuranPath = 'assets/xmltojson.json';

const String kId = "id";
const String kJozz = "jozz";
const String kSuraNo = "sura_no";
const String kSuraNameEn = "sura_name_en";
const String kSuraNameAr = "sura_name_ar";
const String kPage = "page";
const String kLineStart = "line_start";
const String kLineEnd = "line_end";
const String kAyaNo = "aya_no";
const String kAyaText = "aya_text";
const String kAyaTextEmlaey = "aya_text_emlaey";
const String kAyaTafseer = "aya_tafseer";
const String kAyaTafseerText = "#text";
const String kAyaTafseerSpan = "span";
