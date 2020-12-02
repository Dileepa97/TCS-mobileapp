// //TODO:bug fix
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:timecapturesystem/services/storage_service.dart';
// import 'package:timecapturesystem/services/utils.dart';
//
// class UploadImage extends StatefulWidget {
//   UploadImage() : super();
//
//   final String title = "Upload Image Demo";
//   static const String id = "upload_image";
//
//   @override
//   UploadImageState createState() => UploadImageState();
// }
//
// class UploadImageState extends State<UploadImage> {
//   static final String uploadEndPoint = 'http://localhost:8080/api/files';
//
//   String contentTypeHeader = 'application/json';
//
//   Future<File> file;
//   String status = '';
//   String base64Image;
//   File tmpFile;
//   String errMessage = 'Error Uploading Image';
//
//   chooseImage() {
//     setState(() {
//       file = ImagePicker.pickImage(source: ImageSource.gallery);
//     });
//     setStatus('');
//   }
//
//   setStatus(String message) {
//     setState(() {
//       status = message;
//     });
//   }
//
//   startUpload() async {
//     setStatus('Uploading Image...');
//     if (null == tmpFile) {
//       setStatus(errMessage);
//       return;
//     }
//     String id = await TokenStorageService.idOrEmpty;
//     String fileName = id + '@' + DateTime.now().toIso8601String();
//
//     upload(fileName);
//   }
//
// //TODO : fix this shit
//   upload(imageFileName) async {
//     var authHeader = await generateAuthHeader();
//     http.post(uploadEndPoint,
//         body: MultipartFile.fromBytes(base64Image, [1, 2, 3]),
//         headers: {
//           HttpHeaders.authorizationHeader: authHeader,
//           HttpHeaders.contentTypeHeader: contentTypeHeader
//         }).then((result) {
//       setStatus(result.statusCode == 200 ? result.body : errMessage);
//     }).catchError((error) {
//       setStatus(error.toString());
//     });
//   }
//
//   Widget showImage() {
//     return FutureBuilder<File>(
//       future: file,
//       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             null != snapshot.data) {
//           tmpFile = snapshot.data;
//           base64Image = base64Encode(snapshot.data.readAsBytesSync());
//           return Flexible(
//             child: Image.file(
//               snapshot.data,
//               fit: BoxFit.fill,
//             ),
//           );
//         } else if (null != snapshot.error) {
//           return const Text(
//             'Error Picking Image',
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return const Text(
//             'No Image Selected',
//             textAlign: TextAlign.center,
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(30.0),
//           child: Column(
//             children: <Widget>[
//               (imageUrl != null)
//                   ? Image.network(imageUrl)
//                   : Placeholder(
//                       fallbackHeight: 200.0, fallbackWidth: double.infinity),
//               SizedBox(
//                 height: 20.0,
//               ),
//               RaisedButton(
//                 child: Text('Upload Image'),
//                 color: Colors.lightBlue,
//                 onPressed: () => upload(imageFileName),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //
// // Column(
// // crossAxisAlignment: CrossAxisAlignment.stretch,
// // children: <Widget>[
// // OutlineButton(
// // onPressed: chooseImage,
// // child: Text('Choose Image'),
// // ),
// // SizedBox(
// // height: 20.0,
// // ),
// // showImage(),
// // SizedBox(
// // height: 20.0,
// // ),
// // OutlineButton(
// // onPressed: startUpload,
// // child: Text('Upload Image'),
// // ),
// // SizedBox(
// // height: 20.0,
// // ),
// // Text(
// // status,
// // textAlign: TextAlign.center,
// // style: TextStyle(
// // color: Colors.green,
// // fontWeight: FontWeight.w500,
// // fontSize: 20.0,
// // ),
// // ),
// // SizedBox(
// // height: 20.0,
// // ),
// // ],
// // ),
