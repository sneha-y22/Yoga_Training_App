import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/constants/constants.dart';

Future<Map<String, dynamic>> getProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final res = await http.get(
    Uri.parse('$baseUrl/auth/profile'),
    headers: {'Authorization': 'Bearer $token'},
  );

  return jsonDecode(res.body);
}
