import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/view/user_management/user_details_screen.dart';

class UserCard extends StatefulWidget {
  final User user;
  final User loggedUser;

  const UserCard({
    Key key,
    this.user,
    this.loggedUser,
  });

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var vIcon = widget.user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = widget.user.verified ? Colors.green : Colors.redAccent;
    var cardColor = (widget.user.id != widget.loggedUser.id &&
            widget.user.highestRoleIndex < widget.loggedUser.highestRoleIndex)
        ? Colors.white
        : Colors.white70;

    var imageURL = widget.user.profileImageURL == null
        ? 'default.png'
        : widget.user.profileImageURL;
    return GestureDetector(
      onTap: () {
        if (widget.user.id != widget.loggedUser.id &&
            widget.user.highestRoleIndex < widget.loggedUser.highestRoleIndex)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDetails(user: widget.user)),
          );
      },
      child: Container(
        height: 80,
        child: Card(
          color: cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: imageURL == 'default.png'
                    ? AssetImage('images/default.png')
                    : NetworkImage(fileAPI + imageURL),
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
