import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.lato(
            fontSize: 18,
          ),
        ),
      ),
      home: const MyHomePage(title: 'To Do:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // in order to use the text field input we need to use a TextEditingController
  // initialize a textediting controller
  final TextEditingController _controller = TextEditingController();
  List<String> tasks = [];
  List<bool> checked = [];

  void addTask() {
    String enteredText = _controller.text;
    setState(() {
      // add list tile to listview
      tasks.add(enteredText);
      checked.add(false);
    });
  }

  void removeTask() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // List of tasks
            Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        subtitle: Text(tasks[index]),
                        value: checked[index],
                        onChanged: (bool? newValue) {
                          setState(() {
                            checked[index] = newValue!;
                          });
                        });
                  }),
            ),
            TextField(
              // attach the controller to textfield
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter task name',
              ),
            ),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
