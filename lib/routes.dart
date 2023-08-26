import 'package:go_router/go_router.dart';
import 'package:task_tracker/home_page.dart';
import 'package:task_tracker/task_form.dart';

final routes = [
  GoRoute(
      path:'/home',
      builder: (context,state) => const MyHomePage(title: 'Home Page')
  ),
  GoRoute(
      path: '/form',
      builder: (context,state) => TaskForm()
  )
];