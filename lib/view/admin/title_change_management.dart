import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/auth/title.dart' as titleModel;
import 'package:timecapturesystem/services/auth/title_service.dart';

import '../constants.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var titleAPI = apiEndpoint + 'title/';

class TitleChangeManagementScreen extends StatefulWidget {
  static const String id = "title_change_management_screen";

  @override
  _TitleChangeManagementScreenState createState() =>
      _TitleChangeManagementScreenState();
}

class _TitleChangeManagementScreenState
    extends State<TitleChangeManagementScreen> {
  TextEditingController _titleController = TextEditingController();

  Color _titleInitColor = Colors.lightBlueAccent;

  bool spin = false;

  var _titleName;
  var titleNames = ['None'];
  var titles;
  titleModel.Title _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Change Title",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
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
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: FutureBuilder<dynamic>(
                    future: TitleService.getTitles(),
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
                SizedBox(
                  height: 30.0,
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
                      .copyWith(hintText: 'New Title Name'),
                ),
                SizedBox(
                  height: 47.0,
                ),
                RoundedButton(
                  color: Colors.redAccent,
                  onPressed: () async {
                    var confirmed = await displayChangeTitleSureDialog(context);

                    if (confirmed) {
                      if (_titleName.isEmpty || _titleName == 'Title') {
                        return;
                      }
                      setState(() {
                        spin = true;
                      });
                      //implement login
                      try {
                        int code = await TitleService.changeTitle(
                            _title, _titleController.text);

                        if (code == 200) {
                          setState(() {
                            spin = false;
                            _titleName = null;
                            _titleController.clear();
                          });
                          displayDialog(
                              context, "Success", "Title changed successfully");
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
                    }
                  },
                  title: 'Change',
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
