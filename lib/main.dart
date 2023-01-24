import 'package:flutter/material.dart';
import 'package:todo_project/main_todo.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      title: 'Todo Project',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            TodoWidget(),
          ],
        ),
      ),
    );
  }
}
