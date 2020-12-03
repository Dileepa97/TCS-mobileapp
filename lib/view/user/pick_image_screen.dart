import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/services/storage_service.dart';
import 'package:timecapturesystem/services/utils.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var uploadEndPoint = apiEndpoint + 'files';

const contentTypeHeader = 'application/json';

class PickImageScreen extends StatefulWidget {
  static const String id = "pick_image_screen";

  PickImageScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  //final ImagePicker _imagePicker = ImagePickerChannel();

  File _imageFile;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.file(_imageFile),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.lightBlueAccent.shade700,
                radius: 33.0,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
              onTap: () async {
                await _cropImage();
              },
            ),
          ),
        ],
      );
    } else {
      return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _buildImage(),
              ),
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              if (_imageFile != null)
                _buildActionButton(
                  key: Key('send'),
                  text: 'Upload',
                  onPressed: () => uploadImage(_imageFile, context),
                ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.white,
          textColor: Colors.black,
          onPressed: onPressed),
    );
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
}

uploadImage(File imageFile, context) async {
  var authHeader = await generateAuthHeader();
  var id = await TokenStorageService.idOrEmpty;
  Dio dio = Dio();
  try {
    String fileName = id + '@' + DateTime.now().toIso8601String();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: fileName)
    });

    Response res = await dio.post(uploadEndPoint,
        data: formData,
        options:
            Options(headers: {"accept": "*/*", "Authorization": authHeader}));
    if (res != null) {
      if (res.statusCode == 200) {
        displayDialog(context, "Success", "Successfully uploaded your image");
      } else {
        displayDialog(
            context, "Error", "An error occurred while uploading image");
      }
    }
  } catch (e) {}
}
