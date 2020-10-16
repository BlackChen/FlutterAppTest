import 'package:FlutterAppTest/ShopingList/ShopingList.dart';
import 'package:FlutterAppTest/ShopingList/ShoppingListItem.dart';
import 'package:FlutterAppTest/base/KPDetailPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'RandomWords/RandomWords.dart';
import 'model/KnowledgePoint.dart';

class FlutterMenu extends StatefulWidget {
  @override
  createState() => new FlutterMenuState();
}

class FlutterMenuState extends State<FlutterMenu> {
  final _studyList = <KnowledgePoint>[
    new KnowledgePoint( name: '基础组件', sId: 100 ),
    new KnowledgePoint(name: 'jj', sId: 101),
    new KnowledgePoint(name: 'kk', sId: 102),
    new KnowledgePoint(name: 'll', sId: 103),
  ];//datasource
  final _biggerFont = const TextStyle(fontSize: 18.0);//字体大小

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16),

        itemBuilder: (context, i){
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index < _studyList.length)
            return _buildRow(_studyList[index]);
        }
    );
  }

  Widget _buildRow(KnowledgePoint pair){
    return new ListTile(
      title: new Text(
        pair.name,
        style: _biggerFont,
      ),
      onTap: (){
        _pushNext(pair);
      },

    );
  }

  ///知识下一级
  void _pushNext (KnowledgePoint s){
    if (s.sId > 0) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder:(context){
              final page = new KPDetailPage();
              page.point = s;
              return new Scaffold(
                body: page,
              );
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
              body: new ShoppingList(
                products: <Product>[
                  new Product(name: 'Flower'),
                  new Product(name: 'Flour'),
                  new Product(name: 'Chocolate chips'),
                ],
              ),
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