// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;
// import 'package:file_picker/file_picker.dart';
//
// class PdfUploader extends StatefulWidget {
//   @override
//   _PdfUploaderState createState() => _PdfUploaderState();
// }
//
// class _PdfUploaderState extends State<PdfUploader> {
//   File? _pdfFile;
//   String? _pdfUrl;
//
//   Future<void> _pickPDF() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null) {
//       setState(() {
//         _pdfFile = File(result.files.single.path!);
//       });
//     }
//   }
//
//   Future<void> _uploadPDF() async {
//     if (_pdfFile == null) return;
//
//     Reference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('pdfs/${path.basename(_pdfFile!.path)}');
//     UploadTask uploadTask = storageReference.putFile(_pdfFile!);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//     setState(() {
//       _pdfUrl = downloadUrl;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Uploader'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_pdfFile != null)
//               Container(
//                 margin: EdgeInsets.only(bottom: 20),
//                 child: ElevatedButton(
//                   onPressed: _uploadPDF,
//                   child: Text('Upload PDF'),
//                 ),
//               ),
//             ElevatedButton(
//               onPressed: _pickPDF,
//               child: Text('Select PDF'),
//             ),
//             if (_pdfUrl != null)
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Navigate to a PDF viewer page passing the _pdfUrl
//                   },
//                   child: Text('View PDF'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
