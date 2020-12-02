import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/view/user_management/user_details_screen.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  });

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var vIcon = widget.user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = widget.user.verified ? Colors.green : Colors.redAccent;

    var imageURL = widget.user.profileImageURL == null
        ? 'default.png'
        : widget.user.profileImageURL;
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(user: widget.user)),
        );
      },
      child: Container(
        height: 80,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(fileAPI + imageURL),
              ),
              Container(
                width: 150,
                child: Text(widget.user.fullName),
              ),
              Icon(
                vIcon,
                color: vIconColor,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
