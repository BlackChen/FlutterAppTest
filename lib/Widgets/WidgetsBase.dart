import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerTest extends StatefulWidget {
  @override
  createState() => _ContainerTestState();
}

class _ContainerTestState extends State<ContainerTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(width: 5, color: Colors.red),
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(20)),
        image: new DecorationImage(
          image: new NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602837901660&di=9456844073d25a25e4d6153f2b5f8aa5&imgtype=0&src=http%3A%2F%2Fimg14.360buyimg.com%2Fn0%2Fjfs%2Ft517%2F244%2F889008948%2F123223%2F290789db%2F5493f50anee8a3e47.png'),
          centerSlice: new Rect.fromLTRB(270, 150, 1200, 700),
        ),
      ),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: new Text('Hello World!',
      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
      ),
      transform: new Matrix4.rotationZ(0.1),//旋转


    );
  }
}

class RowColumnTest extends StatefulWidget {
  @override
  createState() => _RowColumnTestState();
}

class _RowColumnTestState extends State<RowColumnTest> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(//Column: 竖直方向 Row: 水平方向
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,//CrossAxis: 交叉
        textBaseline: TextBaseline.ideographic,//
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
          Icon(Icons.ad_units_rounded, color: Colors.red,),

          Row(
            children: [
              RaisedButton(
                textTheme: ButtonTextTheme.accent,
                color: Colors.teal,
                onPressed: (){
                  print('RaisedButton');
                },
                child: Text(
                  'RaisedButton',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.access_alarm),
                tooltip: "ToolTip",
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: const Border(),
                onPressed: () {
                  print('FloatingActionButton');
                  //click callback
                },
              )

            ],
          ),


          Image.network(
            'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1005344786,776190137&fm=26&gp=0.jpg',
            fit: BoxFit.cover,
            color: Colors.white,
            colorBlendMode: BlendMode.color,//添加滤镜
            repeat: ImageRepeat.noRepeat,
          ),
          Container(
            color: Colors.blue,
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
        ],
      ),
    );
  }
}

