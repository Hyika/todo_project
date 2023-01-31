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

    return SingleChildScrollView(
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
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => setState(() {
        _tapped = !_tapped;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: _tapped ? 100 : 40,
        width: deviceWidth,
        margin: const EdgeInsets.all(11),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: !_tapped,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    '일정을 추가하려면 눌러주세요',
                    style: TextStyle(
                      color: Color.fromARGB(255, 136, 136, 136),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _tapped,
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 46,
                          margin: EdgeInsets.fromLTRB(6, 6, 6, 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                  child: Container(
                                width: deviceWidth * 0.27,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 235, 238),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.alarm,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        '시간 설정',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              GestureDetector(
                                  child: Container(
                                width: deviceWidth * 0.27,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 235, 238),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        '기한 설정',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              GestureDetector(
                                  child: Container(
                                width: deviceWidth * 0.27,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 235, 238),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.notification_add,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        '알림 설정',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          )),
                      Container(
                        height: 36,
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 9),
                        child: TextField(
                          controller: _txtController,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.center,
                          onSubmitted: (value) {
                            if (value != '') {
                              _txtList.add(value);
                              _txtController.clear();
                              _tapped = !_tapped;
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
      ),
    );
  }
}
