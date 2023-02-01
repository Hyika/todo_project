import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> _txtList = [];

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTodoPage()),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      '오늘 할 일',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTodoPage()),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    '오늘 할 일',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTodoPage extends StatefulWidget {
  const MyTodoPage({super.key});

  @override
  State<MyTodoPage> createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final _txtController = TextEditingController();
  bool _tapped = false;

  void _handleSubmitted(String text) {
    if (text != '') {
      setState(() {
        _txtList.add(text);
        _txtController.clear();
        _tapped = !_tapped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () => setState(() {
          _tapped = !_tapped;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: _tapped ? 100 : 40,
          width: deviceWidth,
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(13.0))),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: !_tapped,
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
                  visible: _tapped,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
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
                                onTap: () =>
                                    _handleSubmitted(_txtController.text),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 141, 255, 240)),
                                  child:
                                      const Icon(Icons.arrow_upward_outlined),
                                ),
                              )
                            ],
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
    print('rebuild?>');
    return ListView.builder(
      itemCount: _txtList.length,
      itemBuilder: (context, index) {
        final String item = _txtList[index];
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 3, 12, 3),
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
              child: todoListContainer(item),
            ),
          ),
        );
      },
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

  void _handleSubmitted(String text) {
    if (text != '') {
      _txtList.add(text);
      _txtController.clear();
      _tapped = !_tapped;
    }
    _txtController.clear();
  }

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
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(13.0))),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: !_tapped,
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
                visible: _tapped,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
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
                              onTap: () =>
                                  _handleSubmitted(_txtController.text),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 141, 255, 240)),
                                child: const Icon(Icons.arrow_upward_outlined),
                              ),
                            )
                          ],
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
