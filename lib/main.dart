import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  // final String title;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var description = [];
  var meter = [];
  var count = [];
  var cycle = [];

  var meterState = 0;
  var countState = 0;
  var cycleState = 0;

  addNameArr(name) {
    // 자식 위젯에서 입력한 값을 전달받아 Array Update
    setState(() {
      description.add(name);
      // meter.add(meter);
      // count.add(count);
      // cycle.add(cycle);
    });
  }

  meterArr(m) {
    setState(() {
      meter.add(m);
    });
  }

  countArr(c) {
    setState(() {
      count.add(c);
    });
  }

  cycleArr(c) {
    setState(() {
      cycle.add(c);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '수영 훈련 앱',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: description.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: Text(
              meter[i].toString(),
            ),
            title: TextButton(
              child: Text(
                description[i],
              ),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DialogUI(
                    Meter: meter[i],
                    Count: count[i],
                    Cycle: cycle[i],
                    Name: description[i],
                  );
                },
              ),
            ),
            trailing: ElevatedButton(
              child: const Text('GO'),
              onPressed: () {
                setState(
                  () {
                    // debugPrint('');
                    // meter[i] += 25;
                    // count[i] += 1;
                    // cycle[i] += 10;
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return InsertDialogUI(
                addNameArr: addNameArr,
                meterArr: meterArr,
                countArr: countArr,
                cycleArr: cycleArr,
              );
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  const DialogUI({Key? key, this.Meter, this.Count, this.Cycle, this.Name})
      : super(key: key);
  final Meter; // 부모 위젯으로부터 전달받은 변수 등록
  final Count;
  final Cycle;
  final Name; // 부모 위젯으로부터 전달받은 변수 등록

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.white,
      //Dialog Main Title
      title: Column(
        children: <Widget>[
          Text("훈련 소개"),
          Text('${Meter}미터'),
          Text('${Count}개수'),
          Text('${Cycle}초'),
        ],
      ),
      //
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "설명 : ${Name}",
          ),
        ],
      ),
      actions: <Widget>[
        // ElevatedButton(
        //   onPressed: () => Navigator.pop(context, 'Cancel'),
        //   child: const Text('Cancel'),
        // ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('확인'),
        ),
      ],
    );
  }
}

class InsertDialogUI extends StatelessWidget {
  InsertDialogUI(
      {Key? key, this.addNameArr, this.meterArr, this.countArr, this.cycleArr})
      : super(key: key);
  final addNameArr; // 부모 위젯에서 전달받은 변수(함수)
  final meterArr;
  final countArr;
  final cycleArr;

  final _meterFieldController = TextEditingController();
  final _countFieldController = TextEditingController();
  final _cycleFieldController = TextEditingController();
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('훈련 추가'),
      content: Column(
        children: <Widget>[
          // 이 부분에 미터 개수 초 피커 추가 해야 함
          TextField(
            controller: _meterFieldController,
            decoration: const InputDecoration(hintText: "미터 설정"),
          ),
          TextField(
            controller: _countFieldController,
            decoration: const InputDecoration(hintText: "개수 설정"),
          ),
          TextField(
            controller: _cycleFieldController,
            decoration: const InputDecoration(hintText: "초 설정"),
          ),
          TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "훈련 설명"),
          ),
        ],
      ),

      // content: TextField(
      //   controller: _textFieldController,
      //   decoration: const InputDecoration(hintText: "훈련을 추가하세요."),
      // ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('취소'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            addNameArr(_textFieldController.text);
            meterArr(_meterFieldController.text);
            countArr(_countFieldController.text);
            cycleArr(_cycleFieldController.text);
            Navigator.pop(context);
          },
          child: const Text('확인'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
          ),
        ),
      ],
    );
  }
}
