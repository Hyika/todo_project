import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            '오늘 할 일',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          height: deviceHeight * 0.45,
          child: ListItemBuilder(),
        ),
      ],
    );
  }
}

// Todo list maker
class ListItemBuilder extends StatefulWidget {
  const ListItemBuilder({super.key});

  @override
  State<ListItemBuilder> createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilder> {
  int cnt = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cnt,
      itemBuilder: (context, index) {
        if (index == cnt - 1) {
          return GestureDetector(
            onTap: () => setState(() {
              cnt++;
            }),
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 161, 161, 161),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                children: <Widget>[
                  Container(
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: const Text('일정을 추가하려면 여기를 눌러주세요.'),
                  ),
                ],
              ),
            ),
          );
        } else
          return Container(
            padding: EdgeInsets.only(left: 4.0),
            height: 30.0,
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.circle_outlined,
                    size: 15
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Test',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          );
      },
    );
  }
}
