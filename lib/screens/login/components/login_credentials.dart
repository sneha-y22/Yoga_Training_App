import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/constants/constants.dart';
import 'package:yoga_app/screens/home/home_screen.dart';



class LoginCredentials extends StatelessWidget {
  const LoginCredentials({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please Log In',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75,
                    horizontal: appPadding),
                fillColor: white,
                hintText: 'Email',
                suffixIcon: Icon(
                  Icons.email_outlined,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75,
                    horizontal: appPadding),
                fillColor: Colors.white,
                hintText: 'Password',
                suffixIcon: Icon(
                  Icons.lock_outline,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Center(
            child: Text(
              'Forget Password!',
              style: TextStyle(
                  fontSize: 18, color: black.withOpacity(0.4)),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ),
            child: Material(
                elevation: 10.0,
                shadowColor: primary,
                color: primary,
                borderRadius: BorderRadius.circular(30.0),
                child: SizedBox(
                  width: size.width,
                  height: size.width * 0.15,
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data['token']);
    prefs.setString('userId', data['user']['_id']);
    // Navigate to home_screen.dart
  } else {
    // Handle login error
  }
}

