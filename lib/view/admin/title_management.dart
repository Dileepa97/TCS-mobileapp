import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/auth/title.dart' as titleModel;
import 'package:timecapturesystem/services/auth/title_service.dart';
import 'package:timecapturesystem/view/admin/title_change_management.dart';

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

  var titleNames = ['Pick Title'];
  String _selectedTitleName = 'Pick Title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Title Management",
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
                  height: 40.0,
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
                  decoration: inputDeco(_titleInitColor, _titleController)
                      .copyWith(hintText: 'Title Name'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.green,
                  onPressed: () async {
                    var confirmed = await displayAddTitleSureDialog(context);

                    if (confirmed) {
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
                        int code = await TitleService.addTitle(
                          _titleController.text,
                        );
                        if (code == 200) {
                          displayDialog(context, "Success",
                              "New title added successfully");
                          _titleController.clear();
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
                        setState(() {
                          spin = false;
                        });
                      }
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
                    future: TitleService.getTitles(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        titleNames = ['Pick Title'];
                        for (titleModel.Title title in snapshot.data) {
                          titleNames.add(title.name);
                        }
                        return dropDownList(titleNames);
                      } else {
                        titleNames = ['Pick Title'];
                        return dropDownList(titleNames);
                      }
                    },
                  ),
                ),
                RoundedButton(
                  color: Colors.red,
                  onPressed: () async {
                    var confirmed = await displayDeleteTitleSureDialog(context);

                    if (confirmed) {
                      if (_selectedTitleName.isEmpty ||
                          _selectedTitleName == 'Pick Title') {
                        return;
                      }
                      setState(() {
                        spin = true;
                      });
                      //implement login
                      try {
                        int code =
                            await TitleService.deleteTitle(_selectedTitleName);

                        if (code == 200) {
                          displayDialog(
                              context, "Success", "Title deleted successfully");
                          setState(() {
                            spin = false;
                            _selectedTitleName = null;
                          });
                        } else {
                          setState(() {
                            spin = false;
                          });
                        }
                      } catch (e) {
                        displayDialog(context, "Error", e.toString());
                        setState(() {
                          spin = false;
                        });
                      }
                    }
                  },
                  title: 'Delete',
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, TitleChangeManagementScreen.id);
                  },
                  title: 'Edit Titles',
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
        value: _selectedTitleName,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pick Title'),
          ],
        ),
        items: inputTitles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _selectedTitleName = value;
          });
        },
      ),
    );
  }
}
