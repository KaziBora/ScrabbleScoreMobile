import 'package:app/providers/game.dart';
import 'package:app/screens/game_menu_screen.dart';

import '../widgets/add_user_widget.dart';
import '../widgets/user_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = "/users";

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<String> values = ["", "", "", null, null];

  void addUser(int number) => setState(() {
        values[number] = "";
      });
  void deleteUser(int number) => setState(() {
        values.removeAt(number);
        values.add(null);
      });

  @override
  Widget build(BuildContext context) {
    final nullIndex = values.indexOf(null);
    final appBar = AppBar(title: const Text("ScrabbleScoreMobile"));
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height,
            child: Column(
              children: <Widget>[
                Spacer(
                  flex: values[3] == null ? 1 : 2,
                ),
                UserInputWidget(1, values, null),
                UserInputWidget(2, values, null),
                if (values[3] != null)
                  UserInputWidget(
                    3,
                    values,
                    deleteUser,
                    textController: TextEditingController(text: values[3]),
                  ),
                if (values[4] != null)
                  UserInputWidget(
                    4,
                    values,
                    deleteUser,
                    textController: TextEditingController(text: values[4]),
                  ),
                if (nullIndex != -1) AddUserWidget(nullIndex, addUser),
                Spacer(
                  flex: values[3] == null ? 1 : 2,
                ),
                RaisedButton(
                  child: const Text("Rozpocznij rozgrywkę"),
                  onPressed: () {
                    Provider.of<Game>(context, listen: false)
                        .setPlayersNames(values);
                    Navigator.of(context).pushReplacementNamed(
                      GameMenuScreen.routeName,
                    );
                  },
                ),
                Spacer(
                  flex: values[3] == null ? 1 : 3,
                ),
              ],
            ),
          ),
        ));
  }
}