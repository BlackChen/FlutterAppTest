import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AnimatedTest.dart';
import 'ChipTest.dart';
import 'ExpansionPanelTest.dart';
import 'StepperTest.dart';

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
        '/expanl': (BuildContext context) => ExpansionPanelDemo(),
        '/chip': (BuildContext context) => FilterChipDemo(),
        '/inputchip': (BuildContext context) => InputChipDemo(),
        '/step': (BuildContext context) => StepperPage(),
        '/Animated': (BuildContext context) => AnimatedDemo(),
        '/heroAnimated': (BuildContext context) =>  MyHomePage(),
      },
      initialRoute: '/first',
    );
  }
}


class FirstPage extends StatelessWidget {
  FocusNode userFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    void createAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '跳转?',
              textAlign: TextAlign.center,
            ),
            titlePadding: EdgeInsets.all(10),
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            content: Text('确认跳到第二页?'),
            contentTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
            ],
            actionsPadding: EdgeInsets.all(10),
            actionsOverflowButtonSpacing: 10,
            backgroundColor: Colors.white,
            elevation: 10,
            // clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }
      );

    }


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
                Navigator.pushNamed(context, '/second');

                // createAlertDialog();//对话框
              },
            ),

            TextField(
              focusNode: userFocusNode,
              onChanged: (text) {
                print("输入改变时: " + text);
              },
            ),

            RaisedButton(
              child: Text('停止编辑'),
              onPressed: () {
                userFocusNode.unfocus();
                print('清除输入框聚焦');
              },
            ),

          ],
        ),

      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showMySimpleDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor:Colors.deepOrange,
            title: const Text('对话框标题',textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  print('第一行信息');
                  // 使用showDialog后，手动关闭当前dialog，其实原因很简单，因为dialog其实是另一个页面，准确地来说是另一个路由，
                  // 因此dialog的关闭也是通过navigator来pop的，所以它的地位跟你当前主页面一样。
                  Navigator.pop(context);
                },
                child: const Text('第一行信息'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  print('第二行信息');
                  Navigator.pop(context);
                },
                child: const Text('第二行信息'),
              ),
            ],
          );
        },
      );
    }


    bool _isExpanded = false;


    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Column(
        children: [
          RaisedButton(
              child: Text('对话框'),
              onPressed: _showMySimpleDialog
          ),

          RaisedButton(
              child: Text('折叠列表'),
              onPressed: (){
                Navigator.pushNamed(context, '/expanl');
              }
          ),

          RaisedButton(
              child: Text('Chip'),
              onPressed: (){
                // '/inputchip'
                Navigator.pushNamed(context, '/inputchip');
          }),

          CupertinoButton(
              child: Text('Animated'),
              onPressed: (){
                Navigator.pushNamed(context, '/Animated');
              }
          ),

          CupertinoButton(
              child: Text('heroAnimated'),
              onPressed: (){
                Navigator.pushNamed(context, '/heroAnimated');
              }
          ),

          RaisedButton(
              child: Text('StepperPage'),
              onPressed: (){
                // '/inputchip'
                Navigator.pushNamed(context, '/step');
              }),

          RaisedButton(
              child: Text('SnakBar'),
              onPressed: (){
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('showSnackBar'),
                    backgroundColor: Colors.black54,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: '知道了',
                      onPressed: () {
                        Scaffold.of(context).removeCurrentSnackBar();
                      },
                    ),
                    duration: Duration(seconds: 5),
                    onVisible: () {
                      print('onVisible');
                    },
                  )
                );
              }
          ),
        ],
      ),
    );
  }
}

