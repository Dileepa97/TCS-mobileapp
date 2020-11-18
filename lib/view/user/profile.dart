import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/UserService.dart';

const fileAPI = 'http://192.168.8.100:8080/api/files/';

class Profile extends StatefulWidget {
  static const String id = "profile_screen";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
        child: FutureBuilder<User>(
          future: UserService().getUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              var _user = snapshot.data;
              var vIcon = _user.verified ? Icons.verified : Icons.cancel;
              var vIconColor =
                  _user.verified ? Colors.lightGreenAccent : Colors.redAccent;

              children = <Widget>[
                CircleAvatar(
                  radius: 90.0,
                  backgroundImage:
                      NetworkImage(fileAPI + _user.profileImageURL),
                ),
                Text(
                  _user.fullName,
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _user.username,
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Color.fromARGB(100, 214, 238, 255),
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
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.lightBlueAccent.shade100,
                  ),
                ),
                Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue.shade900,
                      ),
                      title: Text(
                        _user.telephoneNumber,
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blue.shade900,
                      ),
                      title: Text(
                        _user.email,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.blueGrey.shade900,
                            fontFamily: 'Source Sans Pro'),
                      ),
                    ))
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('loading'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
