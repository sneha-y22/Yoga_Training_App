import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yoga_app/constants/constants.dart';
import 'package:yoga_app/screens/home/components/courses.dart';
import 'package:yoga_app/screens/home/components/diff_styles.dart';
import 'package:yoga_app/screens/home/components/profile_screen.dart';
import 'package:yoga_app/screens/home/components/play_screen.dart';
import 'package:yoga_app/screens/home/components/search_screen.dart';
import 'package:yoga_app/screens/home/components/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIconIndex = 2;

  final List<Widget> _screens = const [
    PlayScreen(),
    SearchScreen(),
    HomePageContent(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _navigateToProfile() {
    setState(() {
      selectedIconIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isHome = selectedIconIndex == 2;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: !isHome,
        backgroundColor: Colors.white,
        elevation: 0,
        title: isHome
            ? Row(
                children: [
                  GestureDetector(
                    onTap: _navigateToProfile,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/propic.jpeg"), // Replace with your asset path
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sneha Yadav',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              )
            : null,
        actions: isHome
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {},
                ),
              ]
            : null,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _screens[selectedIconIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIconIndex,
        buttonBackgroundColor: primary,
        height: 60.0,
        color: white,
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 200),
        items: const <Widget>[
          Icon(Icons.play_arrow_outlined, size: 30, color: Colors.black),
          Icon(Icons.search, size: 30, color: Colors.black),
          Icon(Icons.home_outlined, size: 30, color: Colors.black),
          Icon(Icons.favorite_border_outlined, size: 30, color: Colors.black),
          Icon(Icons.person_outline, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}

// Home Page Content as a separate widget
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: appPadding),
      child: Column(
        children: const [
          // CustomAppBar(),  <-- REMOVE this line!
          DiffStyles(),
          Courses(),
        ],
      ),
    );
  }
}






