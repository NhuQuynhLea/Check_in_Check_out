import 'package:check_in_check_out/CameraScreen.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

import 'Login/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraScreen(),
    );
  }
}




