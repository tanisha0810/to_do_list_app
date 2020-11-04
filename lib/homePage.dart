import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> task = [];
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do List'),
      ),
      body: Column(
        children: [
          Image.asset('assets/bg.png'),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.yellow[100],
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(task[index]),
                      child: ListTile(
                        tileColor: Colors.orange[200 + index % 6 * 100],
                        title: Text('${task[index]}'),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          task.removeAt(index);
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemCount: task.length),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Add New Task',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            task.add(_textController.text);
            _textController.clear();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
