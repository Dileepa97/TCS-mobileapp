import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';

import 'admin_leave_card.dart';

class UserNameText extends StatelessWidget {
  const UserNameText({
    Key key,
    @required this.userId,
    this.fontSize,
  }) : super(key: key);

  final String userId;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserService.getUserById(userId),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        Widget _name;
        if (snapshot.hasData) {
          List<String> _userName = snapshot.data.fullName.split(' ');

          _name = Text(
            _userName.elementAt(0) + ' ' + _userName.elementAt(1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Source Sans Pro',
              fontSize: fontSize,
            ),
          );
        } else {
          _name = Text('');
        }
        return _name;
      },
    );
  }
}

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key key,
    @required this.userId,
    this.height,
    this.width,
  }) : super(key: key);

  final String userId;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserService.getUserById(userId),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        Widget _avatar;
        if (snapshot.hasData) {
          User _user = snapshot.data;

          _avatar = CircleAvatar(
            backgroundImage: _user.profileImageURL == 'default.png'
                ? AssetImage('images/default.png')
                : NetworkImage(fileAPI + _user.profileImageURL),
            backgroundColor: Colors.white,
          );
        } else {
          _avatar = CircleAvatar(
            backgroundImage: AssetImage('images/default.png'),
            backgroundColor: Colors.white,
          );
        }
        return Container(
            height: height,
            width: width,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: _avatar);
      },
    );
  }
}
