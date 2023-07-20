class TafseerSource {
  int? id;
  String? name;
  String? language;
  String? author;
  String? bookName;

  TafseerSource(
      {this.id, this.name, this.language, this.author, this.bookName});

  TafseerSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    language = json['language'];
    author = json['author'];
    bookName = json['book_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['language'] = this.language;
    data['author'] = this.author;
    data['book_name'] = this.bookName;
    return data;
  }
}
