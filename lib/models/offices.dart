// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Office {
  String officeName;
  String password;
  Office({
    required this.officeName,
    required this.password,
  });
}

class Offices with ChangeNotifier {
  String _token = "";
  String get token {
    return _token;
  }

  Future<bool> login(String username, String password) async {
    try {
      final response =
          await http.post(Uri.parse('http://ptitsure.tk:9296/app/login'),
              body: json.encode({
                'username': "pm3",
                'password': "123456",
              }));
      final data = json.decode(response.body);
      _token = data['token'];
      if (response.statusCode == 200) {
        print(_token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
