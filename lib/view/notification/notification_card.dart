import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/other/notification.dart' as N;
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

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
    var category = widget.notification.category;
    return GestureDetector(
      //TODO: push according to notification
      onTap: () {
        if (category == 'reg' ||
            category == 'profile-update-A' ||
            category == 'profile-update-NA' ||
            category == 'leave-request' ||
            category == 'leave-status-change' ||
            category == 'leave-cancelled')
          Navigator.pushNamed(
              context, notificationClicked(widget.notification.category));
      },
      child: Container(
        padding: EdgeInsets.all(0),
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

  String notificationClicked(String cat) {
    //
    switch (cat) {
      case 'reg':
        {
          return UserManagementDashboard.id;
        }
      case 'leave-request':
        {
          //return lms path
          return '/allLeaves';
        }
      case 'leave-status-change':
        {
          //return lms path
          return '/ownLeave';
        }
      case 'leave-cancelled':
        {
          //return lms admin path
          return '/allLeaves';
        }
      case 'profile-update-NA':
        {
          return UserManagementDashboard.id;
        }
      case 'profile-update-A':
        {
          return UserManagementDashboard.id;
        }
      case 'task-reassigned':
        {
          return '';
        }
    }
    return '';
  }
}
