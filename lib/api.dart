import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String url = "http://localhost:3000";

  Future<Map<String, dynamic>> signUp(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/signup'),
      headers: {'Content': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return {'success': true, 'message': 'User created successfully'};
    } else {
      final responseBody = jsonDecode(response.body);
      return {'success': false, 'message': responseBody['message']};
    }
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$url/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'token': responseBody['token'],
        'message': responseBody['message']
      };
    } else {
      final responseBody = jsonDecode(response.body);
      return {'success': false, 'message': responseBody['message']};
    }
  }
}
