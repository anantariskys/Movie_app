import 'package:movie_app/models/Genre.dart';

class Anime {
  final int id;
  final String title;
  final String synopsis;
  final String imageUrl;
  final double score;
  final List<Genre> genres;
  Anime({required this.id, required this.title, required this.imageUrl,required this.synopsis,required this.score,required this.genres});

  factory Anime.fromJson(Map<String, dynamic> json) {
    var genresFromJson = json['genres'] as List;
    List<Genre> genreList = genresFromJson.map((genre) => Genre.fromJson(genre)).toList();
    return Anime(
      synopsis: json['synopsis'],
      id: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['large_image_url']?? '',
      score: (json['score'] is int)
          ? (json['score'] as int).toDouble()
          : (json['score'] as num?)?.toDouble() ?? 0.0,
      genres: genreList,
    );
  }
}
