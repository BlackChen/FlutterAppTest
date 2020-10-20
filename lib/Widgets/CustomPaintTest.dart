import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class CanvasAnimateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CanvasAnimateWidgetState();
  }
}

class _CanvasAnimateWidgetState extends State<CanvasAnimateWidget> with SingleTickerProviderStateMixin {

  static const MAX_VALUE = 750.0;
  static const VALUE = 500.0;

  AnimationController controller;
  Animation<double> animation;
  var value = VALUE;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration : Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.0, end : VALUE).animate(controller)
      ..addListener(() { setState(() {});});
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: DashBoardPainter(value: animation.value, maxValue: MAX_VALUE),
        size: Size(300, 300),
      ),
    );
  }

}

class DashBoardPainter extends CustomPainter {

  static const int GRID_NUM = 24;

  var maxValue;
  var value;

  DashBoardPainter({this.maxValue, this.value});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    //1.绘制背景。
    _drawBg(canvas, paint, size);
    //2.绘制圆弧。
    _drawArc(canvas, paint, size);
  }

  _drawBg(Canvas canvas, Paint paint, Size size) {
    paint..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  _drawArc(Canvas canvas, Paint paint, Size size) {
    var padding = 10.0;
    var width = size.width - 2*padding;
    var height = size.height - padding;
    canvas.save();
    canvas.translate(padding, padding);

    //1.绘制灰色的外环。
    paint..color = Colors.white10
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: Offset(width/2, height/2), radius: min(height, width)/2), pi, pi, false, paint);

    //2.根据比例绘制白色的外环。
    paint..color = Colors.white;
    var faction = value / maxValue;
    canvas.drawArc(Rect.fromCircle(center: Offset(width/2, height/2), radius: min(height, width)/2), pi, pi * faction, false, paint);

    //3.绘制刻度的环。
    var arcX = 10.0;
    var arcWidth = 10.0;
    paint..strokeWidth = arcWidth..color = Colors.white10;
    canvas.drawArc(Rect.fromCircle(center: Offset(width/2, height/2), radius: width/2 - arcX - arcWidth/2), pi, pi, false, paint);

    //4.绘制刻度的横线，已经跨过的部分是白色，否则为浅色。
    paint.strokeWidth = 2.0;
    var threadHold = (value / (maxValue / GRID_NUM));
    for (var i = 0; i <= GRID_NUM; i++) {
      canvas.save();
      paint.color = i <= threadHold ? Colors.white : Colors.white24;
      canvas.translate(width/2, height/2);
      canvas.rotate(pi*i/GRID_NUM);
      canvas.translate(-width/2, -height/2);
      canvas.drawLine(Offset(arcX, height/2), Offset(arcX+arcWidth, height/2), paint);
      canvas.restore();
    }

    //5.绘制文字。
    TextSpan textSpan = TextSpan(
        style: TextStyle(
            color: Colors.white,
            fontSize: 50
        ),
        text: '${(value as double).toStringAsFixed(0)}'
    );
    TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(width/2 - textPainter.width/2, height/3));
    canvas.restore();
  }


  @override
  bool shouldRepaint(DashBoardPainter oldDelegate) =>
      (maxValue != oldDelegate.maxValue || value != oldDelegate.value);
}

/**
 * 类说明：毛玻璃
 */
class FrostedGlassDemo extends StatelessWidget {
  FrostedGlassDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('毛玻璃效果'),
      ),
      body: Stack(
        children: <Widget>[
          //约束性盒子
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.network("http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg"),
          ),
          Center(
            //可裁切的矩形
            child: ClipRect(
              //背景过滤器
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                child: Opacity(
                  opacity: 0.1,
                  child: Container(
                    width: 200.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade200
                    ),
                    child: Center(
                      child: Text("天河区扛把子",style:TextStyle(fontSize: 20,color: Colors.black),),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}