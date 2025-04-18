import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of favorite course titles
    final favoriteCourses = [
      {'title': 'Morning Flow', 'duration': '20 min'},
      {'title': 'Core Strength', 'duration': '30 min'},
    ];

    return ListView.builder(
      itemCount: favoriteCourses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text(favoriteCourses[index]['title']!),
          subtitle: Text(favoriteCourses[index]['duration']!),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}

