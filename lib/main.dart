import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/login_screen.dart';
import '../models/offices.dart';
import '../models/users.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Offices())),
        ChangeNotifierProvider(create: (context) => Users()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google ML Kit Demo App'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: const [
//                   ExpansionTile(
//                     title: Text('Vision APIs'),
//                     children: [
//                       // CustomCard('Barcode Scanning', BarcodeScannerView()),
//                       CustomCard('Face Detection', FaceDetectorView()),
//                       // CustomCard('Image Labeling', ImageLabelView()),
//                       // CustomCard('Object Detection', ObjectDetectorView()),
//                       // CustomCard('Text Recognition', TextRecognizerView()),
//                       // CustomCard('Digital Ink Recognition', DigitalInkView()),
//                       // CustomCard('Pose Detection', PoseDetectorView()),
//                       // CustomCard('Selfie Segmentation', SelfieSegmenterView()),
//                     ],
//                   ),
//                   // SizedBox(
//                   //   height: 20,
//                   // ),
//                   // ExpansionTile(
//                   //   title: const Text('Natural Language APIs'),
//                   //   children: [
//                   //     CustomCard('Language ID', LanguageIdentifierView()),
//                   //     CustomCard(
//                   //         'On-device Translation', LanguageTranslatorView()),
//                   //     CustomCard('Smart Reply', SmartReplyView()),
//                   //     CustomCard('Entity Extraction', EntityExtractionView()),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomCard extends StatelessWidget {
//   final String _label;
//   final Widget _viewPage;
//   final bool featureCompleted;

//   const CustomCard(this._label, this._viewPage,
//       {Key? key, this.featureCompleted = true})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.only(bottom: 10),
//       child: ListTile(
//         tileColor: Theme.of(context).primaryColor,
//         title: Text(
//           _label,
//           style:
//               const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         onTap: () {
//           if (!featureCompleted) {
//             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content: Text('This feature has not been implemented yet')));
//           } else {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => _viewPage));
//           }
//         },
//       ),
//     );
//   }
// }
