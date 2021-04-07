import 'package:flutter/material.dart';

//done
class DashBoardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final double height;
  final bool isIcon;

  const DashBoardButton(
      {Key key,
      this.icon,
      this.title,
      this.route,
      this.height,
      this.isIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: this.height,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: isIcon
            ? //big button
            Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(
                      this.icon,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Expanded(
                    child: Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.lightBlue.shade800,
                      ),
                    ),
                  ),
                ],
              )
            : // small button
            Text(
                this.title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.lightBlue.shade800,
                ),
                textAlign: TextAlign.center,
              ),
      ),
      onTap: () {
        Navigator.pushNamed(context, this.route);
      },
    );
  }
}
