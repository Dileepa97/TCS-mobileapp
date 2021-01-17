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
    var vIcon = Icons.email;
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserDetails(user: widget.notification)),
        // );
      },
      child: Container(
        height: 80,
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(
                vIcon,
                size: 50.0,
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
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
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
