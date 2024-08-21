import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/anime.dart';
import '../models/PopularAnime.dart';

class AnimeServices {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> fetchAnimes({int page = 1, int limit = 6, String q =''}) async {
    final uri = Uri.parse('$baseUrl/anime?page=$page&limit=$limit&q=$q');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> animesData = jsonData['data'];
      return animesData.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load animes');
    }
  }

  Future<List<Anime>> fetchPopularAnimes({int page = 1, int limit = 7}) async {
    final uri = Uri.parse('$baseUrl/top/anime?page=$page&limit=$limit');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> animesData = jsonData['data'];
      return animesData.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load animes');
    }
  }
}
