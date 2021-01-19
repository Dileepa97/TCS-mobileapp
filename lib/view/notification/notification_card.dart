import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/notification/notification.dart' as N;
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
  var vIcon;
  @override
  Widget build(BuildContext context) {
    //TODO:make changes to below according to values of notification

    var vIconColor = Colors.black87;
    vIcon = notificationIcon(widget.notification.category);
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
          color:
              widget.notification.seen ? Color(0xFFfafafa) : Color(0xFFD2FBFF),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.notification.content),
                        ),
                      ],
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
          vIcon = Icons.account_circle;
          return UserManagementDashboard.id;
        }
      case 'leave-request':
        {
          vIcon = Icons.directions_walk_outlined;
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

  IconData notificationIcon(String cat) {
    //
    switch (cat) {
      case 'reg':
        {
          return Icons.account_circle;
        }
      case 'leave-request':
        {
          return Icons.directions_walk_outlined;
        }
      case 'leave-status-change':
        {
          return Icons.directions_walk_outlined;
        }
      case 'leave-cancelled':
        {
          return Icons.directions_walk_outlined;
        }
      case 'profile-update-NA':
        {
          return Icons.account_circle;
        }
      case 'profile-update-A':
        {
          return Icons.account_circle;
        }
      case 'task-reassigned':
        {
          return Icons.notifications_none;
        }
    }
    return Icons.notifications_none;
  }
}
