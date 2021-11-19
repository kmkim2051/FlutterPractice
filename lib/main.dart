import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> timeList = [
    "06:00",
    "06:30",
    "06:00",
    "06:30",
    "06:00",
    "06:30",
    "06:00",
    "06:30",
    "06:00",
    "06:30",
    "06:00",
    "06:30"
  ];

  List<String> timeListAM = [];
  List<String> timeListPM = [];
  List<bool> isSelectedAM = [];
  List<bool> isSelectedPM = [];

  ButtonStyle buildButtonStyle(Color color) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      primary: color, // 초록
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    );
    return buttonStyle;
  }

  @override
  void initState() {
    for (int i = 6; i <= 11; i++) {
      timeListAM.add("$i:00");
      timeListAM.add("$i:30");
    }
    for (int i = 12; i <= 21; i++) {
      timeListPM.add("$i:00");
      timeListPM.add("$i:30");
    }
    isSelectedAM = List.filled(timeListAM.length, false);
    isSelectedPM = List.filled(timeListPM.length, false);
  }

  List<InkWell> _buildButtonsWithTimes(
      List<String> timeList, ButtonStyle buttonStyle) {
    int cols = 4;
    int rows = timeList.length ~/ cols;
    if (timeList.length % cols != 0) {
      for (int i = 0; i < timeList.length % cols; i++) {
        timeList.add("");
      }
      rows += 1;
    }
    List<InkWell> allButtonList = []; // toggle button
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int idx = i * cols + j;
        if (timeList[idx] == "") break;
        Color boxColor = isSelectedAM[idx] ? Colors.blue : Colors.grey;
        allButtonList.add(InkWell(
          child: Container(
            child: ElevatedButton(
              // style: buttonStyle,
              style: buildButtonStyle(boxColor),
              //   foregroundColor: getColor(green, blue),
              //   backgroundColor: getColor(blue, green),
              // ),
              onPressed: () {
                setState(() => isSelectedAM[idx] = !isSelectedAM[idx]);
              }, // is button valid?
              child: Text(
                timeList[idx],
              ),
            ),
            // decoration: BoxDecoration(
            //   color: isSelectedAM[idx] ? Colors.blue : Colors.transparent,
            // ),
          ),
          // onTap: () {
          //   setState(() => isSelectedAM[idx] = !isSelectedAM[idx]);
          // },
        ));
      }
    }
    return allButtonList;
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle timeOptionButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      primary: Colors.green, // 초록
      onPrimary: Colors.white,
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    );
    return Scaffold(
        body: CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            children: _buildButtonsWithTimes(timeListAM, timeOptionButtonStyle),
          ),
        ),
      ],
    ));
  }
}
