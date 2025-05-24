import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final double borderRadius = 25.0;
  final double paddingValue = 20.0;

  Future<void> _signup() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showDialog('Passwords do not match');
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.1.8:9000/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['detail'] ?? 'Signup failed';
      } catch (_) {
        message = 'Signup failed';
      }
      _showDialog(message);
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder:
          (_) =>
              AlertDialog(title: const Text('Error'), content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/background.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      fillColor: Color(0xffD8D8DD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      fillColor: Color(0xffD8D8DD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Color(0xffD8D8DD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      fillColor: Color(0xffD8D8DD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _signup,
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0xFF1D166D),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
