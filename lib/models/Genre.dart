class Genre {
  final int malId;
  final String type;
  final String name;
  final String url;

  Genre({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'],
      type: json['type'],
      name: json['name'],
      url: json['url'],
    );
  }
}
