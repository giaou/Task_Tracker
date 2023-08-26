import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/data.dart';
import 'package:task_tracker/task_form.dart';



//List of tasks' statuses
List<String> list = <String>['All','Open','In Progress','Complete'];

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
            //display tasks on the screen
            child:  ListView.builder(
              itemCount: taskHolder.taskList.length,
              itemBuilder: (context,index){
                //check if the users want to display all tasks or only tasks with a specific status
                return dropdownValue=="All"|| taskHolder.taskList[index].status==dropdownValue? Visibility(
                  visible: true,
                  child: ListTile(
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
                  ) ,
                )
                    :  const Visibility(visible: false, child: Text(""),);
              },
            ) ,
          ),

        ],
      ),
      //Adding task functions
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.push('/form');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
