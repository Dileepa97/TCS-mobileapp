import 'package:flutter/material.dart';

class PageCard extends StatelessWidget {
  final dynamic child;

  const PageCard({this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Card(
          shadowColor: Colors.black54,
          color: Colors.white,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
