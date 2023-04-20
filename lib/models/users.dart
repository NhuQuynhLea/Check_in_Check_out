// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:http/http.dart' as http;

class User {
  String fullName;
  String faceImage;
  String avatar;
  String officeName;
  int employeeId;

  User({
    required this.fullName,
    required this.faceImage,
    required this.avatar,
    required this.officeName,
    required this.employeeId,
  });
}

class Users with ChangeNotifier {
  List<Face> _userFace = [];

  List<Face> get userFace {
    return [..._userFace];
  }

  void updateUserFace(List<Face> userFaceDetected) {
    _userFace = userFaceDetected;
  }

  Future<bool> detectFace(String img64, String? token) async {
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
}

  // if()

