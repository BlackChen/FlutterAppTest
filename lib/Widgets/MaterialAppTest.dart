import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialApptest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('已进入');
    return MaterialApp(
      title: 'Material Components',
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        '/first': (BuildContext context) => FirstPage(),
        '/second': (BuildContext context) => SecondPage(),
        // '/textfiled': (BuildContext context) => TextFieldPage(),
      },
      initialRoute: '/first',
    );
  }
}


class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一页'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            RaisedButton(
              child: Text('跳转到第二页'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');//2
              },
            ),
            // TextFieldPage(),
          ],
        ),

      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: RaisedButton(
            child: Text('回到上一页'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}