import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncTest extends StatefulWidget {

  @override
  _AsyncTestState createState() => _AsyncTestState();
}

class _AsyncTestState extends State<AsyncTest> {
  StreamController<int> _streamController;
  var _counter = 0;

  @override
  void initState() {
    _streamController = StreamController<int>();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Stream<int> counter() {
    return _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    StringBuffer text = StringBuffer('test Future:');
    String showResult = '';

    Future<CommonModel> fetchPost() async {
      var http = new HttpClient();
      // ignore: close_sinks
      var httpClient = new HttpClient();
      var uri = new Uri.http(
          'www.devio.org', '/io/flutter_app/json/test_common_model.json');
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var result = json.decode(responseBody);
      print(result);
      return CommonModel.fromJson(result);
    }

    testFutures1(text);
    return Column(
      children: [
        Text(text.toString()+' --TODO: Future里面的数据没带过来',
          maxLines: 2,
        ),
        FutureBuilder<CommonModel>(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Input a URL to start');
                case ConnectionState.waiting:
                  return new Center(child: new CircularProgressIndicator());
                case ConnectionState.active:
                  return new Text(showResult);
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return new Text(
                      'error:'+'${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return new Column(children: <Widget>[
                    Text('请求成功'),
                    Image.network('${snapshot.data.icon}'),
                    Text('statusBarColor:${snapshot.data.statusBarColor}'),
                    Text('title:${snapshot.data.title}'),
                    Text('url:${snapshot.data.url}')
                  ]);

                default:
                  return new Container();
              }
            }),

        StreamBuilder<String>(
            initialData: "",
            stream: Stream.periodic(Duration(seconds: 1), (value) {
              return DateTime.now().toString();
            }),
            builder: (context, AsyncSnapshot<String> snapshot) {
              return Column(
                children: [
                  Text('实现每秒钟显示当前的时间'),
                  Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 24.0, color: Colors.red),
                  ),
                ],
              );

            }),
        CupertinoButton(
          child: Text("点击"),
          onPressed: () {
            _streamController.add(++_counter);
          },
        ),
        StreamBuilder<int>(
            initialData: 0,
            stream: counter(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return Column(
                children:[
                  Text('实现数据局部的刷新'),
                  Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              );
            }),
      ],
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;
  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}

Future<void> testFutures1(StringBuffer text) async {

  print('1');
  text.write('1');
  //Future可以实现异步调用，但是有时候我们希望Future里面的任务能够同步执行，这时候await就可以派上用场了
  await Future((){
    print('await Future:6');
    text.write('6');
  });

  Future((){
    print('Future:2');
    text.write('2');
  });
  Future((){
    print('Future:4');
    text.write('4');
  });

  Future((){
    print('Future:5');
    text.write('5');
  });

  print('3');
  text.write('3');


}


