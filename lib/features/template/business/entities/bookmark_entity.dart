class BookmarkEntity {
  late int id;
  late int pageNo;
  late int suraNo;
  late int ayaNo;
  BookmarkEntity(this.id, this.pageNo, this.suraNo, this.ayaNo);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageNo': pageNo,
      'suraNo': suraNo,
      'ayaNo': ayaNo,
    };
  }
  @override
  String toString() {
    return 'Bookmark(id: $id, pageNo: $pageNo, suraNo: $suraNo, ayaNo: $ayaNo)';
  }
}
