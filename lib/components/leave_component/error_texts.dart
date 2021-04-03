import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///connection error in app display text
class ConnectionErrorText extends StatelessWidget {
  const ConnectionErrorText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Connection Error. \nPlease check your connection and try again later",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

///server error displa text
class ServerErrorText extends StatelessWidget {
  const ServerErrorText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "An unknown error occured. \nPlease try again later",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

///custom error text
class CustomErrorText extends StatelessWidget {
  const CustomErrorText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

///loading text
class LoadingText extends StatelessWidget {
  const LoadingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
          Text(
            "Please wait...",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
