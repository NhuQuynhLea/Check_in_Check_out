import 'dart:convert';

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<bool> _detectFace(String img64) async {
    try {
      final response = await http.post(
          Uri.parse('http://ptitsure.tk:9296/app/checkFaceImage'),
          body: json.encode({
            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InBtMyIsInBhc3N3b3JkIjoiM2NjMzI1ZTA0NzhiYzc2NzI5YzU0NmE5MjhlYzYwYzRmYjc4OGMxNzI3MWRjZjJhOGQ3MjM0ZWVhM2Q5NWM3OGU0ZmExYWU0YTE4YjczYmU4ZTVmN2Q5ODM2ZTgzMTkyNDVkODM0NzFkMGMwMDIyYTI2YjdlZWQ0YTFmMmRkMmIiLCJvZmZpY2UiOjE4LCJvcmdhbml6YXRpb24iOjQyLCJyb2xlIjoiUXVcdTFlYTNuIHRyXHUxZWNiIHZpXHUwMGVhbiIsImV4cCI6MTY4MjY2MDgyMn0.oDfLUK273QvKqBLParC4o3kUvUcD6ARTk2MAej5wV3E",
            "face_image": img64,
          }));
      if (response.statusCode == 200) {
        print("successfull");
        var data = jsonDecode(response.body);
        print(data);
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            //convert Path to File
            Uint8List imagebytes = await image.readAsBytes(); //convert to bytes
            String base64string = base64.encode(imagebytes); //convert bytes to base64 string
            print(base64string);
            bool checkImage = await _detectFace(base64string);
            print(checkImage);
            if (!mounted) return;


          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}