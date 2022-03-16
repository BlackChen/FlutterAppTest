import 'dart:ui';

import 'package:FlutterAppTest/Widgets/MaterialAppTest.dart';
import 'package:FlutterAppTest/Widgets/WidgetsBase.dart';
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
    new KnowledgePoint(name: 'Row/Column', sId: 101),
    new KnowledgePoint(name: 'MaterialApptest', sId: 102),
    new KnowledgePoint(name: '触摸水波效果', sId: 103),
  ];//datasource
  final _biggerFont = const TextStyle(fontSize: 18.0);

  KPDetailPageState(KnowledgePoint point){
    this.point = point;
  }//字体大小

  Widget _buildDetailPage() {
    return new ListView.separated(
        itemCount: _studyList.length,
        separatorBuilder: (context, index){
          return new Divider();
        },
        itemBuilder: (context, index){
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (index < _studyList.length-1)
            return _buildRow(_studyList[index]);
          if (index == 3)
            return new InkWell(
              // When the user taps the button, show a snackbar
              onTap: () {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('点击效果'),
                ));
              },
              child: new Container(
                padding: new EdgeInsets.all(18.0),
                child: new Text('触摸水波',semanticsLabel: 'tips',
                ),
              ),
            );
          return Container();
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
              var page = null;

              switch (s.sId){
                case 100:
                  page = new ContainerTest();
                  break;
                case 101:
                  page = new RowColumnTest();
                  break;
                case 102:
                  page = new MaterialApptest();
                  break;
              }

              return new Scaffold(
                appBar: new AppBar(
                  title: Text(s.name),
                ),
                body: page,
              );
            }
        ),
      );
    } else {
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
