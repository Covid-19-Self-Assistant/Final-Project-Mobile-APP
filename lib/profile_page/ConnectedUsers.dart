import 'package:dating_app/components/constants.dart';
import 'package:dating_app/profile_page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ConnectedUsers extends StatefulWidget {
  @override
  _ConnectedUsersState createState() => _ConnectedUsersState();
}

class _ConnectedUsersState extends State<ConnectedUsers> {
  // variables =========>
  List<Connection> userStatus = [];
  List<String> _selectedUsesEmails = [];
  bool isSelectAll = false;
  bool type = false;
  String messageForNoUsersSelected = 'Sorry No users have been selected ?';
  String messageWhenUsersAreSelected =
      'Do you want to send emails for all user(s) ?';
  // end of the variables

  // functions =========>

  void _selectAll() {
    setState(() {
      isSelectAll = true;
    });
    for (var i = 0; i < userStatus.length; i++) {
      _selectedUsesEmails.add(userStatus[i].email);
      setState(() {
        userStatus[i].selectedStatus = true;
      });
    }
    print(_selectedUsesEmails);
  }

  void _clearAll() {
    setState(() {
      isSelectAll = false;
      _selectedUsesEmails.clear();
    });

    for (var i = 0; i < userStatus.length; i++) {
      setState(() {
        userStatus[i].selectedStatus = false;
      });
    }
  }

  void _sendEmailsForUsrs(String day) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                  onPressed: () {
                    type = false;
                    Navigator.of(context).pop();
                  },
                  child:
                      Text(_selectedUsesEmails.length == 0 ? 'Close' : 'No')),
              if (_selectedUsesEmails.length > 0)
                MaterialButton(
                    onPressed: () async {
                      type = true;
                      final Email email = Email(
                        subject: 'Covid 19 warning',
                        body:
                            'This is a warning notice.\n \n I am identified as a covid 19 patient.\n \n As you closely conntected with me in $day be mindfull about this.\n \n Thank you',
                        recipients: _selectedUsesEmails,
                        isHTML: false,
                      );
                      try {
                        await FlutterEmailSender.send(email);
                      } catch (e) {
                        print(e);
                      }

                      _clearAll();

                      // TODO: send the api call to store sync data in database

                      Navigator.of(context).pop();
                    },
                    child: Text('Yes')),
            ],
            content: Text(_selectedUsesEmails.length == 0
                ? messageForNoUsersSelected
                : messageWhenUsersAreSelected),
          );
        });
  }

  void _toggleSelectingUsers(int index, bool value) {
    print(_selectedUsesEmails.length);
    print(userStatus.length);
    setState(() {
      userStatus[index].selectedStatus = value;
      if (value == true) {
        if (_selectedUsesEmails.length == userStatus.length - 1) {
          setState(() {
            isSelectAll = true;
          });
        }
        _selectedUsesEmails.add(userStatus[index].email);
      } else {
        setState(() {
          isSelectAll = false;
        });
        _selectedUsesEmails
            .removeWhere((element) => element == userStatus[index].email);
      }
    });
  }

  // build method =============>
  @override
  Widget build(BuildContext context) {
    List<Connection> connections =
        ModalRoute.of(context)!.settings.arguments as List<Connection>;
    userStatus = connections;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: isSelectAll ? _clearAll : _selectAll,
        child: Text(
          isSelectAll ? "Clear All" : "Select All",
          textAlign: TextAlign.center,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Connected users"),
        actions: [
          IconButton(
            onPressed: () => _sendEmailsForUsrs(userStatus[0].day),
            icon: Icon(Icons.email),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: userStatus.length,
        itemBuilder: (context, index) {
          return Card(
            child: CheckboxListTile(
              title: Row(children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  child: Text(userStatus[index].user[0]),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(userStatus[index].user),
              ]),
              // title: Text(userStatus[index].userName),
              value: userStatus[index].selectedStatus,
              onChanged: (value) => _toggleSelectingUsers(index, value!),
            ),
          );
        },
      ),
    );
  }
}
