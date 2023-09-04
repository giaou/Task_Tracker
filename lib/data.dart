import 'package:flutter/material.dart';

class Task {
  int id;
  String? title;
  String? description;
  String? status;
  String? updateTime;
  List<Relationship> relationships;

  Task(this.id, this.title, this.description, this.status, this.updateTime, this.relationships);
}

class Relationship{
  int? relatedTaskID;
  String? label; //relationship between 2 tasks
  Relationship(this.relatedTaskID,this.label);
}

class TaskList with ChangeNotifier{
  final List<Task> _taskList = [Task(1,'Add Task feature','Make the flutter app be able to list the added tasks','Complete',"unknown",[Relationship(2,'is blocked by')]),
                       Task(2,'Watch Youtube','Watch episode 2','Open',"unknown",[Relationship(3,'is subtask of')]),
                       Task(3,'Add the filter','Users will be able to show all tasks or tasks with a specific status','In Progress','unknown',[Relationship(1,'is alternative to')])];

  int _currentIndex = 0;
  // get the whole list
  List<Task> get taskList => _taskList.toList();
  firstTask() => _taskList[_currentIndex];

  addTask(Task task){
    _taskList.add(task);
    notifyListeners();
  }

  updateCurrentTask(Task oldTask, Task newTask){
    final oldIndex = _taskList.indexOf(oldTask);
    //check if task exist?
    if(oldIndex>=0){
      _taskList[oldIndex] = newTask;
    }
    notifyListeners();
  }

  getTaskFromID(int? relatedTaskID){
    Task? relatedTask = _taskList.firstWhere((task) => task.id==relatedTaskID);
    return relatedTask?.title??"unknown";
  }

}