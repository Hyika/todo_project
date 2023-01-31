import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_project/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Statusbar Settings
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: 'Todo Project',
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      )),
      debugShowCheckedModeBanner: false,
      home: MyScaffold(),
    );
  }
}

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Text(
                    '오늘 할 일',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                TodoWidget(),
              ],
            ),
          ),
        ),
        bottomSheet: TextFieldBar(),
      );
  }
}