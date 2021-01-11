import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/absent_user_data.dart';
import 'package:timecapturesystem/view/lms/admin_leave/user_data.dart';

class AbsentUserCard extends StatefulWidget {
  final AbsentUser userData;

  const AbsentUserCard({Key key, this.userData}) : super(key: key);
  @override
  _AbsentUserCardState createState() => _AbsentUserCardState();
}

class _AbsentUserCardState extends State<AbsentUserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 150,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          UserProfileImage(
              userId: widget.userData.userId, height: 60, width: 60),
        ],
      ),
    );
  }
}
