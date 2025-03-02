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
          bodyMedium: GoogleFonts.delius(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Tasks'),
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
  // initialize a text editing controller
  final TextEditingController _controller = TextEditingController();
  List<String> tasks = [];
  List<bool> checked = [];

  void addTask() {
    String enteredText = _controller.text;
    setState(() {
      // adds task to list
      tasks.add(enteredText);
      checked.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: GoogleFonts.delius(fontSize: 40, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25), // padding around column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // List of tasks
            Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // checkbox
                      leading: Checkbox(
                        value: checked[index],
                        onChanged: (bool? newValue) {
                          setState(() {
                            checked[index] = newValue!;
                          });
                        },
                      ),
                      subtitle: Text(tasks[index]),
                      //  delete button
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              tasks.removeAt(index);
                              checked.removeAt(index);
                            });
                          }),
                    );
                  }),
            ),

            TextField(
              // attach the controller to textfield
              controller: _controller,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Enter task name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Add', style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
