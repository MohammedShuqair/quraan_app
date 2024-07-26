class TafseerSource {
  int? id;
  String? name;
  String? language;
  String? author;
  String? bookName;

  TafseerSource(
      {this.id, this.name, this.language, this.author, this.bookName});

  void copyWith(TafseerSource ts) {
    id = ts.id;
    name = ts.name;
    language = ts.language;
    author = ts.author;
    bookName = ts.bookName;
  }

  @override
  operator ==(other) =>
      other is TafseerSource &&
      other.id == id &&
      other.name == name &&
      other.language == language &&
      other.author == author &&
      other.bookName == bookName;

  TafseerSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    language = json['language'];
    author = json['author'];
    bookName = json['book_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['language'] = language;
    data['author'] = author;
    data['book_name'] = bookName;
    return data;
  }
}
