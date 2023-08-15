import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/data.dart';
//List of tasks' statuses
List<String> list = <String>['Open','In Progress','Complete'];
class TaskForm extends StatefulWidget {
  const TaskForm({super.key});


  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {

  //define the global key
  final _formKey = GlobalKey<FormState>();
  //Text Controllers

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController status = TextEditingController();



  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Form(
        key: _formKey,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: title,
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Title of the task cannot be empty';
                }
                return null;
              },
            ),
            TextFormField(
              controller: description,
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
            ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    context.read<TaskList>().addTask(Task(title.text,description.text,dropdownValue));
                    print('Title: ${title.text}, description: ${description.text}, status: $dropdownValue');
                  }
                },
                child:  Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
