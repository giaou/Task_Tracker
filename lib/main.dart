import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/data.dart';
import 'package:task_tracker/task_form.dart';


//List of tasks' statuses
List<String> list = <String>['All','Open','In Progress','Complete'];

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

  //initialize dropdown value
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    final taskHolder = context.watch<TaskList>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            onChanged: (String? value){
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value:value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: (dropdownValue != 'All')?ListView.builder(
              /*shrinkWrap: true,
            itemCount: taskHolder.taskList.length,
            itemBuilder: ((context, index) => Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(taskHolder.taskList[index].title!)
                )
            )),*/
                itemCount: taskHolder.taskList.where((task) => task.status == dropdownValue).length,
                itemBuilder: (context,index){
                  //filterTasks
                  final filterTasks = taskHolder.taskList.where((task) => task.status == dropdownValue ).toList();
                  final currentTask = filterTasks[index];
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xff764abc),
                      child: Text((index+1).toString()),
                    ),
                    title: Text(currentTask.title!),
                    subtitle: Text("${currentTask.description!} | ${currentTask.status!}"),
                    trailing: const Icon(Icons.more_vert),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm(task: currentTask,index: index)));
                    },
                  );
                },
            ) : ListView.builder(
              itemCount: taskHolder.taskList.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff764abc),
                    child: Text((index+1).toString()),
                  ),
                  title: Text(taskHolder.taskList[index].title!),
                  subtitle: Text("${taskHolder.taskList[index].description!} | ${taskHolder.taskList[index].status!}"),
                  trailing: const Icon(Icons.more_vert),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm(task: taskHolder.taskList[index],index: index)));
                  },
                );
              },
            ) ,
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TaskForm()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
