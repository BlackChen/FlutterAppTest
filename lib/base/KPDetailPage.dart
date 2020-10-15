import 'dart:ui';

import 'package:FlutterAppTest/model/KnowledgePoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KPDetailPage extends StatefulWidget {
  KnowledgePoint point;

  @override
  createState() => new KPDetailPageState(point);
}

class KPDetailPageState extends State<KPDetailPage> {
  KnowledgePoint point;

  final _studyList = <KnowledgePoint>[
    new KnowledgePoint( name: 'Container', sId: 100 ),
    new KnowledgePoint(name: 'Row', sId: 101),
    new KnowledgePoint(name: 'Column', sId: 102),
    new KnowledgePoint(name: 'Image', sId: 103),
  ];//datasource
  final _biggerFont = const TextStyle(fontSize: 18.0);

  KPDetailPageState(KnowledgePoint point){
    this.point = point;
  }//字体大小

  Widget _buildDetailPage() {
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
    switch (s.sId){
      case 100:
        print(s.name);
        break;
      default:
        print('该知识点尚未涉及');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(

        title: Text(point.name),

      ),
      body: _buildDetailPage(),
    );
  }

}
