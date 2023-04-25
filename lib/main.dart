import 'package:camera/camera.dart';
import 'package:check_in_check_out/take_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/login_screen.dart';
import '../models/offices.dart';
import '../models/users.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp( MyApp(cameraDescription: firstCamera,));
}

class MyApp extends StatelessWidget {
  final CameraDescription cameraDescription;
  const MyApp({Key? key,required this.cameraDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Offices())),
        ChangeNotifierProvider(create: (context) => Users()),
      ],
      child:   const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
        //TakePictureScreen(camera: cameraDescription),
      ),
    );
  }
}


