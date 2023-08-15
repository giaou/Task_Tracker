import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/data.dart';
import 'package:task_tracker/task_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Tracker_GiaoU'),
      //home:const TaskForm(),
    );*/
    return ChangeNotifierProvider(
      create: (context)=>TaskList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Task Tracker_GiaoU'),
      ),
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

  @override
  Widget build(BuildContext context) {
    final taskHolder = context.watch<TaskList>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  ListView.builder(
            /*shrinkWrap: true,
            itemCount: taskHolder.taskList.length,
            itemBuilder: ((context, index) => Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(taskHolder.taskList[index].title!)
                )
            )),*/
        itemCount: taskHolder.taskList.length,
        itemBuilder: (context,index){
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xff764abc),
              child: Text(index.toString()),
            ),
            title: Text(taskHolder.taskList[index].title!),
            subtitle: Text(taskHolder.taskList[index].description!),
            trailing: const Icon(Icons.more_vert),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskForm()));
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskForm()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
