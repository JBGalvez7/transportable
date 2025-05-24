import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.1.5:8000';

Future<http.Response> signup(String email, String username, String password) {
  return http.post(
    Uri.parse('$baseUrl/signup/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'username': username,
      'password': password,
    }),
  );
}

Future<http.Response> login(String email, String password) {
  return http.post(
    Uri.parse('$baseUrl/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );
}
