import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../CameraScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> login(String username, String password) async {
    try {
      Response response = await post(
          Uri.parse('http://ptitsure.tk:9296/app/login'),
          body: json.encode({
            'username': 'pm3',
            'password': '123456'
          }));

      if (response.statusCode == 200) {
        print("successfull");
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder:(context) =>  const CameraScreen()),
        );
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              controller: usernameController,
            ),
            const SizedBox(height: 26),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock)),
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                login(usernameController.text.toString(),
                    passwordController.text.toString());
              },
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
