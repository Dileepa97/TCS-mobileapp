import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timecapturesystem/models/notification/notification.dart' as N;
import 'package:timecapturesystem/services/notification_service.dart';
import 'package:timecapturesystem/view/notification/notification_card.dart';

class NotificationCenter extends StatefulWidget {
  static const String id = "notification_center_screen";

  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  List<N.Notification> notifications = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    notifications = await NotificationService.fetchMyNotifications(context);
    if (notifications != [] || notifications.length > 0) {
      notifications = notifications.reversed.toList();
    }
    if (mounted) setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Center'),
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
      ),
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
          child: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(
          textStyle: TextStyle(color: Colors.white),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: notifications.length > 0
            ? ListView.builder(
                itemBuilder: (c, i) => Center(
                  child: NotificationCard(notification: notifications[i]),
                ),
                itemExtent: 100.0,
                itemCount: notifications.length,
              )
            : Center(
                child: Container(
                  child: Text(
                    'No new notifications available',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
      )),
    );
  }
}
