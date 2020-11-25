import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/view/user/edit_profile.dart';

const fileAPI = 'http://localhost:8080/api/files/';
// const fileAPI = 'http://192.168.8.100:8080/api/files/';

class UserDetails extends StatefulWidget {
  static const String id = "user_details_screen";

  final User user;

  const UserDetails({
    Key key,
    @required this.user,
  });

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var vIcon = user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = user.verified ? Colors.green : Colors.redAccent;
    var imageURL = ((user.profileImageURL == null)
        ? ('default.png')
        : (user.profileImageURL));
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              user.fullName,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              radius: 90.0,
              backgroundImage: NetworkImage('$fileAPI$imageURL'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              user.username,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontSize: 20.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      user.title == null ? '' : user.title,
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.white70,
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      vIcon,
                      color: vIconColor,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.green.shade900,
                  ),
                  title: Text(
                    user.telephoneNumber,
                    style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.blue.shade900,
                ),
                title: Text(
                  user.email,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueGrey.shade900,
                      fontFamily: 'Source Sans Pro'),
                ),
              ),
            ),
            //TODO:icons for delete verify un-verify assign roles
            Container(
              margin: EdgeInsets.all(15),
              child: FlatButton(
                child: Text(
                  'EDIT',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.white,
                textColor: Colors.black87,
                onPressed: () {},
              ),
            ),
          ],
        ),
      )),
    );
  }
}
