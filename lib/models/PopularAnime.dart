class PopularAnime {
  final int id;
  final String title;
  final String synopsis;
  final String imageUrl;
  final double score;

  PopularAnime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.score,
  });

  factory PopularAnime.fromJson(Map<String, dynamic> json) {
    return PopularAnime(
      synopsis: json['synopsis'] ?? '',
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      score: (json['score'] is int)
          ? (json['score'] as int).toDouble()
          : (json['score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}