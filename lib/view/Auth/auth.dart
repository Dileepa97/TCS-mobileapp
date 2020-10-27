import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Auth',
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Container(
                color: Colors.red,
              ),
            )
          ],
        ));
  }
}
