import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.9,
      inAsyncCall: true,
      child: Container(),
      color: Colors.white,
    );
  }
}
