
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedDemo extends StatefulWidget {
  @override
  createState() => _AnimatedDemoState();
}

class _AnimatedDemoState extends State<AnimatedDemo> {
  bool selected = false;
  var targetText = "T";//用于显示的文案

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          targetText = 'Tap';
          selected = !selected;
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 2),//动画持续时间
            width: selected ? 200 : 100,
            height: selected ? 100 : 200,
            color: selected ? Colors.red : Colors.yellow,
            alignment: Alignment.center, //selected ? Alignment.center : AlignmentDirectional.topEnd,
            curve: Curves.fastLinearToSlowEaseIn,//差值器(动画效果)
            child: Column(
              children: [
                DragTarget (
                  onWillAccept: (data) => true,//当Draggable传递过来的dada不是null的时候 决定接收该数据。
                  onAccept: (data){
                    print("data2 = $data onAccept");
                    setState(() {
                      targetText = data;//接收该数据后修改文案内容。
                    });
                  },
                  onLeave: (data){
                    print("data3 = $data onLeave");//我来了 我又走了
                  },
                  builder: (context, candidateData, rejectedData) {
                    //这是DragTarget实际展示给用户看到的样子
                    return Container(
                      alignment: Alignment.topCenter,
                      width: 50.0,
                      height: 52.0,
                      color: Colors.blue[500],
                      child: Center(
                        child: Text(targetText, style: TextStyle(fontSize: 12),),
                      ),
                    );
                  },
                ),

                Draggable(
                  data: 'D',
                  axis: Axis.vertical,//控制拖动的方向
                  onDragEnd: (DraggableDetails details){
                    Offset set = details.offset;
                    print('onDragEnd:'+set.dy.toString());
                  },
                  child: Container(
                    height: 50,
                    width: 52,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(targetText, style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),

                  feedback: Container(
                    height: 50,
                    width: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(targetText ,style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),

                ),


              ],
            )
          ),

          AnimatedCrossFade(
              firstChild: const FlutterLogo(size: 100, style: FlutterLogoStyle.horizontal,),
              secondChild: const FlutterLogo(size: 100, style: FlutterLogoStyle.stacked,),
              crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(seconds: 2),
          ),

          AnimatedDefaultTextStyle(
            style: selected ? TextStyle(fontSize: 50, color: Colors.red, fontWeight: FontWeight.w200) : TextStyle(fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
            duration: Duration(seconds: 2),
            ///动画执行插值器
            curve: Curves.bounceInOut,
            ///文本对齐方式
            textAlign: TextAlign.start,
            ///文本是否应该在软换行符处换行
            softWrap: true,
            ///超过文本行数区域的裁剪方式
            ///设置设置为省略号
            overflow: TextOverflow.ellipsis,
            ///最大显示行数
            maxLines: 1,
            ///每当样式有修改触发动画时
            ///动画执行结束的回调
            onEnd: () {
              print("动画执行结束");
            },

            ///文本组件
            child: Text("Hello, Flutter"),
          ),



        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showPhoto(BuildContext context, Widget image) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return GestureDetector(
            child: SizedBox.expand(
              child: Hero(
                tag: image,
                child: image,
              ),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          );
        }));
  }

  List<Widget> _list = <Widget>[
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'assets/images/hanyun.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('flutter之Hero动画'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: const EdgeInsets.all(4.0),
        children: _list.map(
              (Widget img) {
            return GestureDetector(
              onTap: () {
                showPhoto(context, img);
              },
              child: Hero(
                tag: img,
                child: img,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

