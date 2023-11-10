import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/song_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _lastFetchedIndex = 0;
  List<DocumentSnapshot> songs = [];
  bool _isLoading = false;
  String playlistName = 'AthensSongBook';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchSongs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchSongs() async {
    setState(() {
      _isLoading = true; // Set loading to true when start fetching
    });
    // Fetch the songIds from the playlist document
    final playlistDoc = await FirebaseFirestore.instance.collection('playlist').doc(playlistName).get();
    List<String> songIds = List<String>.from(playlistDoc.data()?['songIds'] ?? []);
    // Determine the range of songIds to fetch
    int endIndex = min(_lastFetchedIndex + 20, songIds.length);
    List<String> songIdsToFetch = songIds.sublist(_lastFetchedIndex, endIndex);
    // Fetch each song with the songIds and add them to the songs list
    for (var songId in songIdsToFetch) {
      final songDoc = await FirebaseFirestore.instance.collection('song').doc(songId).get();
      setState(() {
        songs.add(songDoc);
      });
    }
    _lastFetchedIndex = endIndex; // Update the last fetched index
    setState(() {
      _isLoading = false; // Set loading to false when done fetching
    });
  }

  void searchSongs(String searchTerm) async {
    setState(() {
      _isLoading = true; // Set loading to true when start fetching
    });

    // Fetch the songs that have the search term in their keywords
    final songQuerySnapshot = await FirebaseFirestore.instance
        .collection('song')
        .where('titleSubstrings', arrayContains: searchTerm.toLowerCase())
        .get();
    setState(() {
      songs = songQuerySnapshot.docs;
      _isLoading = false; // Set loading to false when done fetching
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchSongs();
    }
  }

  int _selectedIndex = 0;
  static const List<String> playListArray = <String>[
    'AthensSongBook',
    'Hymnal',
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      playlistName = playListArray[index];
      songs = [];
    });
    fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // // final userId = user != null ? user.uid : null;
    // List<Map<String, dynamic>> songArray = [];

    // Future<List<Map<String, dynamic>>> fetchSongArray() async {
    //   final response = await http.get(Uri.parse(
    //       'http://127.0.0.1:8888/api/v1/playlist_songs/Athens%20Songbook')); //'http://127.0.0.1:8888/api/v1/playlist_songs/Hymnal'));

    //   if (response.statusCode == 200) {
    //     List<dynamic> body = jsonDecode(response.body);
    //     //songArray = body.map((dynamic item) => item as Map<String, dynamic>).toList();
    //     return body.map((dynamic item) => item as Map<String, dynamic>).toList();
    //   } else {
    //     throw Exception('Failed to load songs');
    //   }
    // }

    // void addSongsToFirestore() async {
    //   songArray = await fetchSongArray();
    //   final songCollection = FirebaseFirestore.instance.collection('song');
    //   final playlistDoc = FirebaseFirestore.instance.collection('playlist').doc('AthensSongBook');

    //   for (var song in songArray) {
    //     // Check if the song already exists in Firestore
    //     final songQuerySnapshot = await songCollection.where('id', isEqualTo: song['id']).get();

    //     if (songQuerySnapshot.docs.isEmpty) {
    //       // If the song doesn't exist, add it to Firestore
    //       // Generate all substrings of the song title
    //       String title = song['title'];
    //       List<String> titleSubstrings = [];
    //       for (int i = 0; i < title.length; i++) {
    //         for (int j = i + 1; j <= title.length; j++) {
    //           titleSubstrings.add(title.substring(i, j).toLowerCase());
    //         }
    //       }
    //       // Add the titleSubstrings to the song
    //       song['titleSubstrings'] = titleSubstrings;

    //       DocumentReference docRef = await songCollection.add(song);
    //       String songId = docRef.id;
    //       print(songId);
    //       // Add the song ID to the playlist document
    //       await playlistDoc.update({
    //         'songIds': FieldValue.arrayUnion([songId])
    //       });
    //     }
    //   }
    // }

    // addSongsToFirestore();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'AthensSongBook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Hymnal',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   label: 'Favorite Songs',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search songs...',
          ),
          onChanged: (value) => searchSongs(value),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('flutterfire_300x.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const SignOutButton(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: songs.length + (_isLoading ? 1 : 0), // Add one more item for loading indicator
                itemBuilder: (context, index) {
                  if (index >= songs.length) {
                    // If this is the extra item, show loading indicator
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final song = songs[index].data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongDetailPage(song: song),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(song['title']),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
