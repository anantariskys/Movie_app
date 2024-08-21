import 'package:flutter/material.dart';
import 'package:movie_app/screens/AnimeDetailScreen.dart';
import '../models/anime.dart';

Widget popularAnimeCarousel(List<Anime> popularAnimes) {
  return Container(
    height: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Popular Anime',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemCount: popularAnimes.length,
            itemBuilder: (context, index) {
              final anime = popularAnimes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailScreen(anime: anime),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          anime.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,

                          child: Container(
                            padding: const EdgeInsets.all(8.0),

                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                borderRadius:  const BorderRadius.only(
                                    bottomRight: Radius.circular(8.0)
                                )
                            ),

                            child: Text(
                              anime.title,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${anime.score.toStringAsFixed(1)}/10',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              );
            },
          ),
        ),
      ],
    ),
  );
}