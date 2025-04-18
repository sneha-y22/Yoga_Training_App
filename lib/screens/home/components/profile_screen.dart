import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import 'video_screen.dart';
import '../home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  List<dynamic> joinedCourses = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // ignore: avoid_print
      print("Token being sent: $token");

      if (token == null) {
        setState(() {
          errorMessage = "Not logged in.";
          isLoading = false;
        });
        return;
      }

      final profileUrl = Uri.parse('$baseUrl/auth/profile');
      final response = await http.get(
        profileUrl,
        headers: {'Authorization': 'Bearer $token'},
      );

      // ignore: avoid_print
      print("Status code: ${response.statusCode}");
      // ignore: avoid_print
      print("Body: ${response.body}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> user = jsonDecode(response.body);
        setState(() {
          userData = user;
          joinedCourses = user['joinedCourses'] ?? []; // Make sure this key exists in response
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load profile data.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
        isLoading = false;
      });
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const HomePageContent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${userData!['name']}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text("Email: ${userData!['email']}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),

                      const Text("Joined Courses", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      joinedCourses.isEmpty
                          ? const Text("No courses joined yet.")
                          : Column(
                              children: joinedCourses.map((course) {
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(course['title']),
                                    subtitle: Text('${course['duration']} min'),
                                    trailing: const Icon(Icons.play_circle_fill),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => VideoScreen(videoUrl: course['videoUrl']),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),

                      const SizedBox(height: 30),
                      const Text("Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text("Coming soon..."),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: logout,
                          icon: const Icon(Icons.logout),
                          label: const Text("Log Out"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
