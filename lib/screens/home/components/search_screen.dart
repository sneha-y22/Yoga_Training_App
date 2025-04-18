import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _allCourses = [
    'Standing Style',
    'Sitting Style',
    'Advanced Stretchings',
    'Breathing Techniques',
  ];

  List<String> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _filteredCourses = _allCourses;
  }

  void _filterCourses(String query) {
    setState(() {
      _filteredCourses = _allCourses
          .where((course) => course.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search for courses...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _filterCourses,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCourses.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.play_circle_outline),
                title: Text(_filteredCourses[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
