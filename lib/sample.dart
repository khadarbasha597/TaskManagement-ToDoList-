// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:file_picker/file_picker.dart';
//
// class FileUploadPage extends StatefulWidget {
//   @override
//   _FileUploadPageState createState() => _FileUploadPageState();
// }
//
// class _FileUploadPageState extends State<FileUploadPage> {
//   String? _uploadMessage;
//   File? file;
//
//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) return;
//     final path =result.files.single.path!;
//     setState(()=>file=File(path));
//   }
//
//   Future<void> _uploadFile() async {
//     if(file==null){print('no file');};
//     final fileName=file!.path;
//     final destination='files/$fileName';
//
//     FirebaseApi._uploadFile(destination,file!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Upload'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Pick a file'),
//             ),
//             SizedBox(height: 20),
//             file != null
//                 ? Text(file!.path)
//                 : Text('No file selected'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadFile,
//               child: Text('Upload File'),
//             ),
//             SizedBox(height: 20),
//             _uploadMessage != null ? Text(_uploadMessage!) : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FirebaseApi {
//   static UploadTask? _uploadFile( String destination,File file){
//     try{
//       final ref=FirebaseStorage.instance.ref(destination);
//       return ref.putFile(file);
//     }on FirebaseException catch(e){
//       print(e);
//     }
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: FileUploadPage(),
//   ));
// }
