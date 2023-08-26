import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/data.dart';
//List of tasks' statuses
List<String> list = <String>['Open','In Progress','Complete'];
class TaskForm extends StatefulWidget {
  TaskForm({this.task, this.index, super.key});
  Task? task;
  int? index;



  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {

  //define the global key
  final _formKey = GlobalKey<FormState>();


  //Text Controllers

  TextEditingController titleHandler = TextEditingController();
  TextEditingController descriptionHandler = TextEditingController();
  String dropdownValue = list.first;

  @override
  void initState(){
    super.initState();
    if(widget.task!=null){
      titleHandler.text = widget.task!.title!;
      descriptionHandler.text = widget.task!.description!;
      dropdownValue = widget.task!.status!;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.task!=null? const Text('Edit Task'):const Text('Create Task'),
      ),
      body: Form(
        key: _formKey,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleHandler,
              decoration: const InputDecoration(
                  labelText: 'Title'
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Title of the task cannot be empty';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionHandler,
              decoration: const InputDecoration(
                labelText: 'Description'
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Description of the task cannot be empty';
                }
                return null;
              },
            ),
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
            Text(widget.task!=null?widget.task!.updateTime!.toString():""),
            ElevatedButton(
                onPressed: (){
                  print('original: Index: ${widget.index} Title: ${titleHandler.text}, description: ${descriptionHandler.text}, status: $dropdownValue');
                  if(_formKey.currentState!.validate()&&widget.task==null){
                    context.read<TaskList>().addTask(Task(titleHandler.text,descriptionHandler.text,dropdownValue,DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())));
                    print('add: Index: ${widget.index} Title: ${titleHandler.text}, description: ${descriptionHandler.text}, status: $dropdownValue');
                  }
                  else if(_formKey.currentState!.validate()&&widget.task!=null){
                    context.read<TaskList>().updateCurrentTask(Task(titleHandler.text,descriptionHandler.text,dropdownValue,DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),widget.index!);
                    print('edited Index: ${widget.index} Title: ${titleHandler.text}, description: ${descriptionHandler.text}, status: $dropdownValue');
                  }
                  context.pop();
                },
                child:  Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
