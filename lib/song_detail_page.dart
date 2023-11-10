import 'package:flutter/material.dart';

class SongDetailPage extends StatelessWidget {
  final Map song;

  const SongDetailPage({required this.song, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              song['title'],
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20.0),
            Text(
              song['lyrics'],
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
