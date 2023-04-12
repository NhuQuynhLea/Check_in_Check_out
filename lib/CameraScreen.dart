import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as Io;
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _capturedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      if (_capturedImage != null) {
        return Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.file(
                _capturedImage!,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              ),
              ElevatedButton(
                  onPressed: ()  {

                    setState(() => _capturedImage = null);
                  },
                  child: const Text(
                    'Capture Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        );
      }
      return SmartFaceCamera(
          autoCapture: true,
          defaultCameraLens: CameraLens.front,
          onCapture: (File? image) async {
            setState(() => _capturedImage = image);
            if(_capturedImage?.path!= null){
              final bytes = await Io.File(_capturedImage!.path).readAsBytes();
              String img64 = base64Encode(bytes);
              print(img64.substring(0, 100));
              log("0000000");
            }
          },
          onFaceDetected: (Face? face) {
            //Do something
          },
          messageBuilder: (context, face) {
            if (face == null) {
              return _message('Place your face in the camera');
            }
            if (!face.wellPositioned) {
              return _message('Center your face in the square');
            }
            return const SizedBox.shrink();
          });
    }));
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
