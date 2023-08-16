import 'package:flutter/cupertino.dart';

class Task {
  String? title;
  String? description;
  String? status;
  DateTime? updateTime;

  Task( this.title, this.description, this.status, this.updateTime);
}

class TaskList with ChangeNotifier{
  final List<Task> _taskList = [Task('Add Task feature','Make the flutter app be able to list the added tasks','In Progress',DateTime.now()),
                       Task('Watch Youtube','Watch episode 2','Open',DateTime.now())];


  int _currentIndex = 0;

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