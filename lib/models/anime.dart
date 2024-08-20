class Anime {
  final int id;
  final String title;
  final String imageUrl;

  Anime({required this.id, required this.title, required this.imageUrl});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
    );
  }
}
