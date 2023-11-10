# Firebase Song Playlist App

This is a Flutter application that fetches and displays songs from a Firebase Firestore database. The app fetches song IDs from a playlist document in Firestore, then fetches and displays the corresponding songs.

## Features

- Fetches song IDs from a playlist document in Firestore.
- Fetches the corresponding songs from Firestore using the fetched IDs.
- Displays the songs in a list.
- Implements infinite scrolling by fetching and displaying 20 songs at a time.
- Displays a loading indicator while fetching new songs.
- On tap of a song, navigates to a detailed page displaying its lyrics.

## Setup

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch the dependencies.
4. Set up your Firebase project and add your `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) to the project.
5. Run `flutter run` to start the app.

## Code Overview

The main logic of the app is in the `HomeScreen` widget in `lib/home.dart`. The `fetchSongs` method fetches song IDs from a playlist document in Firestore, then fetches the corresponding songs and adds them to the `songs` list. The `ListView.builder` widget in the `build` method displays the songs in the `songs` list.

The `fetchSongs` method fetches 20 songs at a time for efficient data usage and better performance. It keeps track of the last fetched song's index and starts from the next one in the subsequent fetch. A loading indicator is displayed while fetching new songs.

The `SongDetailPage` widget in `lib/song_detail_page.dart` displays the details of a song. When a song in the list is tapped, the app navigates to the `SongDetailPage` and displays the song's lyrics.

The app also includes Firebase authentication features, with sign-in and sign-out buttons.

## Firebase Firestore Structure

The Firestore database includes a `playlist` collection with playlist documents. Each playlist document includes a `songIds` field, which is an array of song IDs.

The `song` collection includes song documents. Each song document's ID corresponds to an ID in a playlist's `songIds` array.

## Platforms

The app supports iOS, Android, and macOS. The platform-specific code is in the `ios`, `android`, and `macos` directories.