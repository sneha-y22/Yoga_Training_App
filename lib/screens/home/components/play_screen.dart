import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> videoCourses = [
      {
        'title': 'Beginner Yoga Flow',
        'thumbnail':
            'https://img.freepik.com/free-photo/woman-practicing-yoga_23-2148917435.jpg',
      },
      {
        'title': 'Stretch & Relax',
        'thumbnail':
            'https://img.freepik.com/free-photo/young-woman-doing-yoga-home_23-2149084781.jpg',
      },
    ];

    return ListView.builder(
      itemCount: videoCourses.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(
              videoCourses[index]['thumbnail']!,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            title: Text(videoCourses[index]['title']!),
            trailing: const Icon(Icons.play_arrow),
          ),
        );
      },
    );
  }
}

