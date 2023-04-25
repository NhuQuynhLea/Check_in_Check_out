import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:developer' as logDev;
import 'camera_view.dart';
import './painter/face_detector_painter.dart';
import 'models/users.dart';

class FaceDetectorView extends StatefulWidget {
  String token;
  FaceDetectorView({required this.token});
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState(token: token);
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  String token;
  _FaceDetectorViewState({required this.token});
  Future<bool> _detectFace(String img64, String? token) async {
    try {
      final response = await http.post(
          Uri.parse('http://ptitsure.tk:9296/app/checkFaceImage'),
          body: json.encode({
            "token": token,
            "face_image": img64,
          }));
      if (response.statusCode == 200) {
        print("successfull");
        var data = jsonDecode(response.body);
        if (data['status'] == 200) log("1111111111");
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

  void checkImage(InputImage image) async {
    if (_isBusy2) return;
    _isBusy2 = true;
    log("00000");
    Uint8List? imagebytes = image.bytes; //convert to bytes
    String base64string = base64Encode(imagebytes as List<int>);
    // print(base64string);
    log("checkIMAGE: $base64string");
    // bool checkImage = await _detectFace(base64string, token);
    // print(checkImage);
    _isBusy2 = false;
  }

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  bool _isBusy2 = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Face Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        // log("CameraView: ${inputImage.inputImageData?.size}");
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
      checkImage(inputImage);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';

      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
