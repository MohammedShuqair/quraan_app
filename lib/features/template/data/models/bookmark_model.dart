import '../../business/entities/bookmark_entity.dart';

class BookmarkModel extends BookmarkEntity {
  BookmarkModel(
    int id,
    int pageNo,
    int suraNo,
    int ayaNo,
  ) : super(id, pageNo, suraNo, ayaNo);
  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
        json['id'], json['pageNo'], json['suraNo'], json['ayaNo']);
  }

}
