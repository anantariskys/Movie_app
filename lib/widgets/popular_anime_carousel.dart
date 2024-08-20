import 'package:flutter/material.dart';
import '../models/anime.dart';

Widget popularAnimeCarousel(List<Anime> popularAnimes) {
  return Container(
    height: 260, // Set a fixed height for the carousel
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Padding(
          padding: EdgeInsets.all(8.0),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        anime.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.black54,
                          child: Text(
                            anime.title,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
