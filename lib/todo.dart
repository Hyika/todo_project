import 'package:flutter/material.dart';

class TodoForm {
  final Key primaryKey;
  final String taskName;
  String? tag = 'nothing';
  bool? isComplete = false;

  TodoForm({required this.primaryKey, required this.taskName, this.tag});
}

List<TodoForm> incompleteList = [];
List<TodoForm> completeList = [];

class MyTodoPage extends StatefulWidget {
  const MyTodoPage({super.key});

  @override
  State<MyTodoPage> createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final _txtController = TextEditingController();
  bool _isWhiteBarTapped = false;
  bool _isGreenBarTapped = false;

  void _handleSubmitted(String text) {
    if (text != '') {
      setState(() {
        TodoForm newForm = TodoForm(
          primaryKey: Key(text),
          taskName: text,
        );
        incompleteList.add(newForm);
        _txtController.clear();
        _isWhiteBarTapped = !_isWhiteBarTapped;
      });
    }
  }

  Widget textFieldBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _txtController,
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '오늘은 어떤 일을 할까요?',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _handleSubmitted(_txtController.text),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 141, 255, 240)),
              child: const Icon(Icons.arrow_upward_outlined),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: const Text(
              '오늘 할 일',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: TodoWidget(),
          ),
          // showingCompleteListBar
          GestureDetector(
            onTap: () => setState(() {
              _isGreenBarTapped = !_isGreenBarTapped;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              height: _isGreenBarTapped ? 250 : 40,
              width: deviceWidth,
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 3),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 101, 238, 96),
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: const Text(
                    '완료된 일정',
                    style: TextStyle(
                      color: Color.fromARGB(255, 82, 82, 82),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // taskAddBar
          GestureDetector(
            onTap: () => setState(() {
              _isWhiteBarTapped = !_isWhiteBarTapped;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: _isWhiteBarTapped ? 100 : 40,
              width: deviceWidth,
              margin: const EdgeInsets.fromLTRB(12, 3, 12, 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: !_isWhiteBarTapped,
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: const Text(
                          '작업을 추가하려면 눌러주세요',
                          style: TextStyle(
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isWhiteBarTapped,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            textFieldBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  Widget leftSlideBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget rightSlideBackground() {
    return Container(
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget todoListContainer(item) {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          // Row - Icon area
          Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.circle_outlined,
              size: 20,
              color: Colors.grey,
            ),
          ),
          // Row - Text area
          SizedBox(
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: incompleteList.length,
      itemBuilder: (context, index) {
        final String item = incompleteList[index].taskName;
        final Key primaryKey = incompleteList[index].primaryKey;
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 3, 12, 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Dismissible(
              key: primaryKey,
              background: leftSlideBackground(),
              // Delete item
              secondaryBackground: rightSlideBackground(),
              // Complete item
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    incompleteList[index].isComplete = true;
                    completeList.add(incompleteList[index]);
                  });
                } else {
                  setState(() {
                    incompleteList.removeAt(index);
                  });
                }
              },
              child: todoListContainer(item),
            ),
          ),
        );
      },
    );
  }
}
