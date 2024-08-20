import 'package:flutter/material.dart';
import 'package:movie_app/widgets/popular_anime_carousel.dart';
import '../services/anime_services.dart';
import '../models/anime.dart';
import '../widgets/anime_grid_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AnimeServices _animeService = AnimeServices();
  final List<Anime> _animes = [];
  final List<Anime> _popularAnimes = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchAnimes();
    _fetchPopularAnimes();
  }

  Future<void> _fetchAnimes({String query = ''}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Anime> fetchedAnimes = await _animeService.fetchAnimes(page: _currentPage, limit: 7, q: query);
      if (fetchedAnimes.isEmpty) {
        setState(() {
          _hasMore = false;
        });
      } else {
        setState(() {
          if (_currentPage == 1) _animes.clear(); // Clear list if new search
          _animes.addAll(fetchedAnimes);
          _currentPage++;
        });
      }
    } catch (e) {
      // Handle the error as needed
      print('Error fetching animes: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPopularAnimes() async {
    try {
      final List<Anime> fetchedPopularAnimes = await _animeService.fetchPopularAnimes(limit: 13);
      setState(() {
        _popularAnimes.addAll(fetchedPopularAnimes);
      });
    } catch (e) {
      // Handle the error as needed
      print('Error fetching popular animes: $e');
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _currentPage = 1;
      _hasMore = true;
    });
    _fetchAnimes(query: _searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: TextField(
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search anime...',
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!_isLoading && _hasMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchAnimes(query: _searchQuery);
          }
          return false;
        },
        child: ListView(
          children: [
        if ( _popularAnimes.isNotEmpty)
            Container(
        padding: const EdgeInsets.fromLTRB(0, 12.0, 0,0),
              child: popularAnimeCarousel(_popularAnimes,
            ))
            ,
            Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8
                ),
                child: Text("All Anime",style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,


                ),),),
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4 / 5,
                  ),
                  itemCount: _animes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == _animes.length - 1 && _hasMore) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AnimeGridItem(anime: _animes[index]);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
