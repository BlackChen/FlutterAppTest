import 'package:FlutterAppTest/ShopingList/ShopingList.dart';
import 'package:FlutterAppTest/ShopingList/ShoppingListItem.dart';
import 'package:FlutterAppTest/base/KPDetailPage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'RandomWords/RandomWords.dart';
import 'Widgets/AsyncTest.dart';
import 'Widgets/CustomPaintTest.dart';
import 'model/KnowledgePoint.dart';

class FlutterMenu extends StatefulWidget {
  @override
  createState() => new FlutterMenuState();
}

class FlutterMenuState extends State<FlutterMenu> {
  final _studyList = <KnowledgePoint>[
    new KnowledgePoint( name: '基础组件', sId: 100 ),
    new KnowledgePoint(name: 'CanvasAnimateWidget', sId: 101),
    new KnowledgePoint(name: 'Async', sId: 102),
    new KnowledgePoint(name: 'ShoppingList', sId: 103),
    new KnowledgePoint(name: ';;;;;;;', sId: 103),
  ];//datasource
  final _biggerFont = const TextStyle(fontSize: 18.0);//字体大小

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16),

        itemBuilder: (context, index){
          if (index < _studyList.length)
            return _buildRow(_studyList[index]);
          return Text('');
        }
    );
  }

  Widget _buildRow(KnowledgePoint pair){
    return Column(
      children: [
        ListTile(
          title: new Text(
            pair.name,
            style: _biggerFont,
          ),
          onTap: (){
            _pushNext(pair);
          },
        ),
        Divider(),
      ],
    );
  }

  ///知识下一级
  void _pushNext (KnowledgePoint s){
    if (s.sId > 0) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder:(context){
              switch (s.sId){
                case 101:
                  return new Scaffold(
                    appBar: new AppBar(
                      title: Text('画板'),
                      actions: [
                      IconButton(icon: Icon(Icons.qr_code), onPressed: _pushFrostedGlassDemo)
                      ],
                    ),
                    body: CanvasAnimateWidget(),
                );
                case 102:
                  return new Scaffold(
                    appBar: new AppBar(
                      title: Text('异步'),

                    ),
                    body: AsyncTest(),
                 );
                case 103:
                  return new Scaffold(
                    body: new ShoppingList()
                  );
                default:
                  final page = new KPDetailPage();
                  page.point = s;
                  return new Scaffold(
                    body: page,
                  );
              }
            }
        ),
      );
    } else {
      print('该知识点尚未涉及');
    }
  }

  /// 商品列表
  void _pushShoping() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder:(context){
            return new Scaffold(
              appBar: new AppBar(
                title: Text('待定'),
              ),
              body: new Text('未定义')
            );
          }
      ),
    );
  }

  /// RandomWords
  void _pushRandomWords() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder:(context){
            return new Scaffold(
              body: new RandomWords(),
            );
          }
      ),
    );
  }
  /// 毛玻璃效果
  void _pushFrostedGlassDemo() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder:(context){
            return new Scaffold(
              body: new FrostedGlassDemo(),
            );
          }
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.accessibility),
          onPressed: _pushShoping,
          tooltip: 'Shoping',
        ),
        title: new Text('Welcome To Flutter'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushRandomWords,
            tooltip: 'List !',
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

}
