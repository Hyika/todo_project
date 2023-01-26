import 'package:flutter/material.dart';

int cnt = 0;
String? inputText;
List<String> txtList = [];

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Title
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
            // Today's Todo list
            Container(
              height: deviceHeight * 0.45,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListItemBuilder(),
            ),
            // add button
            Container(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(11),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: Row(
                  children: <Widget>[
                    // Row - Icon area
                    GestureDetector(
                      onTap: () => setState(() {
                        if (inputText != null && inputText != '') {
                          txtList.add(inputText!);
                          _txtController.clear();
                          cnt++;
                          inputText = '';
                        }
                      }),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                    // Row - Text area
                    SizedBox(
                      width: deviceWidth * 0.7,
                      child: TextField(
                        controller: _txtController,
                        textAlignVertical: TextAlignVertical(y: 0.5),
                        onChanged: (txt) => setState(() {
                          inputText = txt;
                        }),
                        onSubmitted: (_) {
                          if (inputText != null && inputText != '') {
                            txtList.add(inputText!);
                            _txtController.clear();
                            cnt++;
                            inputText = '';
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '오늘은 어떤 일을 할까요?',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cnt,
      itemBuilder: (context, index) {
        // list item container
        return Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              // Row - Icon area
              GestureDetector(
                onTap: () => setState(() {

                }),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.circle_outlined,
                    size: 20,
                    color: Colors.lightGreen,
                  ),
                ),
              ),
              // Row - Text area
              SizedBox(
                child: Text(
                  txtList[index],
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
