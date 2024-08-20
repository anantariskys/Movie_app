import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeServices {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> fetchAnimes() async {
    final response = await http.get(Uri.parse('$baseUrl/anime'));

    if (response.statusCode == 200) {

      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load animes');
    }
  }
}
