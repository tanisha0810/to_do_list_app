import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List to store entries of To Do List
  List<String> task = [];

  //Shared Preferences to store data on local device
  SharedPreferences sharedPreferences;

  //Text Field to take entry from user
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    //Saving Data in shared preferences
    List<String> saveList = task;
    sharedPreferences.setStringList('list', saveList);
  }

  void loadData() {
    //Retrieving Data from shared preferences
    List<String> loadList = sharedPreferences.getStringList('list');
    if (loadList != null) {
      setState(() {
        task = loadList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/bg.png'),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.yellow[100],
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    //To remove entries from To Do List by swiping action
                    key: Key(task[index]),
                    child: ListTile(
                      tileColor: Colors.orange[200 + index % 6 * 100],
                      title: Text('${task[index]}'),
                    ),
                    onDismissed: (direction) {
                      setState(
                        () {
                          task.removeAt(index);
                          saveData();
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: task.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      //To take user entry
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Add New Task',
                      ),
                      onSubmitted: (value) {
                        if (value.length > 0) {
                          setState(
                            () {
                              task.add(value);
                              _textController.clear();
                              saveData();
                            },
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_textController.text.length > 0) {
                        setState(
                          () {
                            task.add(_textController.text);
                            _textController.clear();
                            saveData();
                          },
                        );
                      }
                    },
                    child: Text('ADD'),
                    color: Colors.brown,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
