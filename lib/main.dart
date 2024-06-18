// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Search App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? _image;
//   List? _recognitions;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     await (
//       model: 'assets/model.tflite',
//       labels: 'assets/labels.txt',
//     );
//   }

//   Future<void> _getImageFromGallery() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _recognitions = null; // Clear previous recognitions
//       });

//       classifyImage(_image);
//     }
//   }

//   Future<void> classifyImage(File? image) async {
//     if (image == null) {
//       // Handle the case where _image is null, maybe show an error message
//       return;
//     }

//     final recognitions = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 10,
//       threshold: 0.2,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );

//     setState(() {
//       _recognitions = recognitions;
//     });
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Search App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_image != null)
//               Image.file(
//                 _image!,
//                 height: 200,
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getImageFromGallery,
//               child: Text('Select Image from Gallery'),
//             ),
//             if (_recognitions != null)
//               Column(
//                 children: _recognitions!.map((res) {
//                   return Text(
//                     '${res['label']} (${(res['confidence'] * 100).toStringAsFixed(2)}%)',
//                     style: TextStyle(fontSize: 18),
//                   );
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          _image != null
              ? Image.file(
                  _image!,
                  height: 150,
                  width: 150,
                )
              : Text('No image selected.'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: getImage,
            child: Text('Pick Image from Gallery'),
          ),
        ],
      ),
    );
  }
}
