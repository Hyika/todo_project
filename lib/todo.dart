import 'package:flutter/material.dart';

List<String> _txtList = [];

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

  Widget todoListBuilder(item) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          // Row - Icon area
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          height: deviceHeight * 0.45,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(
            itemCount: _txtList.length,
            itemBuilder: (context, index) {
              final String item = _txtList[index];
              return Container(
                margin: const EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Dismissible(
                    key: Key(item),
                    background: leftSlideBackground(),
                    // Delete item
                    secondaryBackground: rightSlideBackground(),
                    // Complete item
                    onDismissed: (direction) {
                      setState(() {
                        _txtList.removeAt(index);
                      });
                    },
                    child: todoListBuilder(item),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextFieldBar extends StatefulWidget {
  const TextFieldBar({super.key});

  @override
  State<TextFieldBar> createState() => _TextFieldBarState();
}

class _TextFieldBarState extends State<TextFieldBar> {
  final _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      height: 40,
      margin: const EdgeInsets.all(11),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: <Widget>[
          // Row - Icon area
          Container(
            padding: EdgeInsets.all(8),
            child: const Icon(
              Icons.add,
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.7,
            child: TextField(
              controller: _txtController,
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (value) {
                if (value != '') {
                  _txtList.add(value);
                  _txtController.clear();
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
    );
  }
}
