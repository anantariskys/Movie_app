import 'package:flutter/material.dart';
import 'package:movie_app/widgets/CustomAppBar.dart';
import '../models/anime.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: CustomAppBar(title: anime.title),
      body: ListView(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 32,
                  right: -40,
                  child: Image.network(
                    anime.imageUrl,

                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: anime.genres.map((genre) {
                  return Chip(
                    label: Text(genre.name),
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              Text(
                anime.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                anime.synopsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          )
        ],
      ),
    );
  }
}
