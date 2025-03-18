class News {
  News({
    required this.title,
    required this.link,
    required this.detial,
    required this.dateTime,
  });

  final String? title;
  final String? link;
  final dynamic detial;
  final dynamic dateTime;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json["title"],
      link: json["link"],
      detial: json["detial"],
      dateTime: json["dateTime"],
    );
  }
}
