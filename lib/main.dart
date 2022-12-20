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
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
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

  removeNameArr(met, cou, cyc, name) {
    print('삭제 버튼 클림');
    setState(() {
      meter.remove(met);
      count.remove(cou);
      cycle.remove(cyc);
      description.remove(name);
    });
  }

  addNameArr(met, cou, cyc, name) {
    // 자식 위젯에서 입력한 값을 전달받아 Array Update
    print('추가 버튼 클림');
    setState(() {
      meter.add(met);
      count.add(cou);
      cycle.add(cyc);
      description.add(name);
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
                '[${meter[i].toString()}미터]  [${count[i].toString()}개]  [${cycle[i].toString()}초]'),
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
              child: const Text(
                '삭제',
              ),
              onPressed: () {
                setState(
                  () {
                    // 이 부분에서 삭제 구현
                    removeNameArr(meter[i], count[i], cycle[i], description[i]);
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
                // meterArr: meterArr,
                // countArr: countArr,
                // cycleArr: cycleArr,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      //Dialog Main Title
      title: Column(
        children: <Widget>[
          Text("훈련 소개"),
          Text('${Meter}미터'),
          Text('${Count}개'),
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
            style: TextStyle(fontSize: 30),
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
        ElevatedButton(
          // 이 부분에서 출발 타이머 실행 해야 한다
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('출발'),
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
            keyboardType: TextInputType.number,
            controller: _meterFieldController,
            decoration: const InputDecoration(hintText: "미터 설정"),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _countFieldController,
            decoration: const InputDecoration(hintText: "개수 설정"),
          ),
          TextField(
            keyboardType: TextInputType.number,
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
            addNameArr(_meterFieldController.text, _countFieldController.text,
                _cycleFieldController.text, _textFieldController.text);

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
