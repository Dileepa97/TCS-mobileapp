import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/other/notification.dart' as N;

class NotificationCard extends StatefulWidget {
  final N.Notification notification;

  const NotificationCard({
    Key key,
    this.notification,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    //TODO:make changes to below according to values of notification
    var vIcon = Icons.email;
    var vIconColor = Colors.black87;
    return GestureDetector(
      //TODO: push according to notification
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserDetails(user: widget.notification)),
        // );
      },
      child: Container(
        height: 100,
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(
                vIcon,
                size: 50.0,
                color: vIconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.notification.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Expanded(
                      child: Text(widget.notification.content),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
