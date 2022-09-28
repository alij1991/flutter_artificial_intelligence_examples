import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../utils/constants.dart';
import 'home.dart';


class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  Widget build(BuildContext context) {
    pageSize = MediaQuery.of(context).size;
    return Center(
      child: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: Home(),
        title: Text('Flutter AI examples',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).colorScheme.secondary
        ),
        ),
        image: Image.asset('assets/images/AI_icon.png'),
        backgroundColor: Theme.of(context).backgroundColor,
        photoSize: 120,
        loaderColor: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
