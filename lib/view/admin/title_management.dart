import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/auth/title.dart' as titleModel;
import 'package:timecapturesystem/services/auth_service.dart';

import '../constants.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var titleAPI = apiEndpoint + 'title/';

class TitleManagementScreen extends StatefulWidget {
  static const String id = "title_management_screen";

  @override
  _TitleManagementScreenState createState() => _TitleManagementScreenState();
}

class _TitleManagementScreenState extends State<TitleManagementScreen> {
  TextEditingController _titleController = TextEditingController();

  Color _titleInitColor = Colors.lightBlueAccent;

  bool spin = false;

  var title;
  var deletingTitle;
  var _titleName;
  var titleNames = ['None'];
  var titles;

  titleModel.Title _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _titleInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_titleInitColor)
                      .copyWith(hintText: 'Title Name'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_titleController.text.isEmpty) {
                      setState(() {
                        _titleInitColor = Colors.redAccent;
                      });
                      return;
                    }
                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      int code = await AuthService.addTitle(
                        _titleController.text,
                      );
                      if (code == 200) {
                        displayDialog(
                            context, "Success", "New title added successfully");
                        _titleController.clear();
                        var newTitles = await AuthService.getTitles();
                        setState(() {
                          titles = newTitles;
                        });
                        setState(() {
                          spin = false;
                        });
                      } else {
                        setState(() {
                          _titleInitColor = Colors.redAccent;
                          spin = false;
                        });
                      }
                    } catch (e) {
                      displayDialog(context, "Error", e.toString());
                      print(e.toString());
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  title: 'Submit',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: FutureBuilder<dynamic>(
                    future: AuthService.getTitles(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        titles = Map.fromIterable(snapshot.data,
                            key: (e) => e.name, value: (e) => e.id);
                        titleNames = [];
                        for (titleModel.Title title in snapshot.data) {
                          titleNames.add(title.name);
                        }
                      }
                      return dropDownList(titleNames);
                    },
                  ),
                ),
                RoundedButton(
                  color: Colors.red,
                  onPressed: () async {
                    if (deletingTitle.isEmpty || deletingTitle == 'None') {
                      return;
                    }
                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      print(deletingTitle);

                      int code = await AuthService.deleteTitle(deletingTitle);

                      if (code == 200) {
                        displayDialog(
                            context, "Success", "Title deleted successfully");

                        setState(() {
                          spin = false;
                        });
                      } else {
                        setState(() {
                          spin = false;
                        });
                      }
                    } catch (e) {
                      displayDialog(context, "Error", e.toString());
                      print(e.toString());
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  title: 'Delete',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dropDownList(inputTitles) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _titleName,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title'),
          ],
        ),
        items: inputTitles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onTap: () async {},
        onChanged: (String value) {
          setState(() {
            _titleName = value;
            _title = titleModel.Title(titles[value], value);
          });
        },
      ),
    );
  }
}
