# Firebase Song Playlist App

This is a Flutter application that fetches and displays songs from a Firebase Firestore database. The app fetches song IDs from a playlist document in Firestore, then fetches and displays the corresponding songs.

## Features

- Fetches song IDs from a playlist document in Firestore.
- Fetches the corresponding songs from Firestore using the fetched IDs.
- Displays the songs in a list.
- Implements infinite scrolling by fetching and displaying 20 songs at a time.
- Displays a loading indicator while fetching new songs.
- On tap of a song, navigates to a detailed page displaying its lyrics.
- Provides a search bar to search for songs by title. The search is case-insensitive and can match any part of the title.
- Allows navigation between different playlists.
- Users can favorite songs, which are then stored and displayed in a separate 'Favorites' list.

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

## Firebase Firestore Structure

The Firestore database includes two main collections: [playlist](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C131-3%2C131) and [song](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C115-3%2C115).

The [playlist](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C131-3%2C131) collection contains playlist documents. Each playlist document has a [songIds](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#37%2C117-37%2C117) field, which is an array of song IDs. The IDs correspond to the documents in the [song](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C115-3%2C115) collection.

The [song](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C115-3%2C115) collection contains song documents. Each song document's ID corresponds to an ID in a playlist's [songIds](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#37%2C117-37%2C117) array. The song document includes fields like [title](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#13%2C48-13%2C48), [lyrics](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#12%2C65-12%2C65), and [titleSubstrings](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/lib/home.dart#75%2C17-75%2C17) (used for search functionality).

In addition to these, there is a [users](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/lib/home.dart#144%2C62-144%2C62) collection for storing user-specific data. Each user document in this collection has a [favoriteSongs](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/lib/home.dart#147%2C20-147%2C20) field, which is an array of song IDs. These IDs correspond to the user's favorite songs in the [song](file:///Users/jeremiah.parrack/freelance/guitar_tabs/firebase/README.md#3%2C115-3%2C115) collection.

<img width="1360" alt="Screenshot 2023-11-10 at 3 18 19 PM" src="https://github.com/jeremiahlukus/flutter-firestore-relationship/assets/17206638/908f248f-6c33-406e-aa9a-8b5e56509dd1">
<img width="1404" alt="Screenshot 2023-11-10 at 3 18 31 PM" src="https://github.com/jeremiahlukus/flutter-firestore-relationship/assets/17206638/83f33f3f-bcb6-4791-9599-aa91776ed045">
<img width="1396" alt="Screenshot 2023-11-10 at 3 18 38 PM" src="https://github.com/jeremiahlukus/flutter-firestore-relationship/assets/17206638/7b00bddc-2053-49c8-a444-26ab2c3ab215">



# Live Demo




https://github.com/jeremiahlukus/flutter-firestore-relationship/assets/17206638/c37e8d4a-f41f-4f61-9940-909ac44d28b5




## Platforms

The app supports iOS, Android, and macOS. The platform-specific code is in the `ios`, `android`, and `macos` directories.
