import 'package:check_in_check_out/face_detector_view.dart';
import 'package:check_in_check_out/models/offices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loginSuccess = false;

  @override
  Widget build(BuildContext context) {
    final officesData = Provider.of<Offices>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(
          height: height / 3,
          width: width,
        ),
        _loginForm(officesData)
      ])),
    );
  }

  Widget _loginForm(Offices officesData) {
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
              onPressed: () async {
                try {
                  loginSuccess = await officesData.login(
                      usernameController.text, passwordController.text);
                  if (loginSuccess == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) =>
                          FaceDetectorView(token: officesData.token,)),
                    ));
                  }
                } catch (error) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('An error has occurred!'),
                            content:
                                const Text('Please return the login screen!'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('OK'))
                            ],
                          ));
                }
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
