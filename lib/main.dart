import 'package:flutter/material.dart';

import 'pages/customSplashScreen.dart';
import 'utils/themeData.dart';
import 'utils/constants.dart';
import 'package:camera/camera.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AI examples',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: CustomSplashScreen(),
      debugShowCheckedModeBanner: false ,
    );
  }
}