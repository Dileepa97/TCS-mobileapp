import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/managers/orientation.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:timecapturesystem/view/user/profile_screen.dart';

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
  File _imageFile;
  bool spin = false;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print('error');
      displayDialog(context, "Error", e.toString());
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
      return Text('Pick or take an image to start',
          style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    OrientationManager.portraitMode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: spin,
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

  uploadImage(File imageFile, context) async {
    setState(() {
      spin = true;
    });
    var authHeader = await generateAuthHeader();
    var id = await TokenStorageService.idOrEmpty;
    Dio dio = Dio();
    var timer = Timer(Duration(seconds: 10), () {
      setState(() {
        spin = false;
      });
      displayDialog(context, "Error", "Request Timeout");
      Navigator.pop(context);
      Navigator.pop(context);
    });
    try {
      String fileName = id +
          '@' +
          DateTime.now().toIso8601String().replaceAll(RegExp("[-:.]*"), '');

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path, filename: fileName)
      });

      Response res = await dio.post(uploadEndPoint,
          data: formData,
          options:
              Options(headers: {"accept": "*/*", "Authorization": authHeader}));

      if (res != null) {
        timer.cancel();
        if (res.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, Profile.id);
        } else if (res.statusCode == 417) {
          Navigator.pop(context);
          displayDialog(context, "Error", "File too large");
        } else {
          displayDialog(
              context, "Error", "An error occurred while uploading image");
        }
        setState(() {
          spin = false;
        });
      } else {
        displayDialog(
            context, "Error", "An error occurred while uploading image");
      }
      setState(() {
        spin = false;
      });
    } catch (e) {
      timer.cancel();
      setState(() {
        spin = false;
      });
      print(e.toString());
      displayDialog(
          context, "Upload Error", "An error occurred while uploading image ");
    }
  }
}
