import 'package:flutter/material.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/background.png'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Image(
                height: 300,
                width: 300,
                image: AssetImage('assets/transportable_logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            child: Image(
              height: 200,
              width: 200,
              image: AssetImage('assets/transportable_logo.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('From BESTRI', style: TextStyle()),
          ),
        ],
      ),
    );
  }
}
*/