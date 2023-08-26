import 'package:flutter/cupertino.dart';

class Task {
  String? title;
  String? description;
  String? status;
  String? updateTime;

  Task( this.title, this.description, this.status, this.updateTime);
}

class TaskList with ChangeNotifier{
  final List<Task> _taskList = [Task('Add Task feature','Make the flutter app be able to list the added tasks','Complete',"unknown"),
                       Task('Watch Youtube','Watch episode 2','Open',"unknown"),
                       Task('Add the filter','Users will be able to show all tasks or tasks with a specific status','In Progress','unknown')];


  int _currentIndex = 0;
  // get the whole list
  List<Task> get taskList => _taskList.toList();
  firstTask() => _taskList[_currentIndex];

  addTask(Task task){
    _taskList.add(task);
    notifyListeners();
  }

  updateCurrentTask(Task task, int index){
    _taskList[index] = task;
    notifyListeners();
  }

}