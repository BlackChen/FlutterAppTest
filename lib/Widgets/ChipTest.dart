

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputChipDemo extends StatefulWidget {
  @override
  _InputChipDemoState createState() => _InputChipDemoState();
}

class _InputChipDemoState extends State<InputChipDemo> {
  List<String> list = [
    "摇滚",
    "音乐",
    "机车党",
    "Android工程师",
    "全栈",
    "Python",
    "UI设计师",
    "测试小姐姐",
    "后台单身狗",
    "产品老大",
    "路边摊",
    "火锅 串串 麻辣烫",
    "篮球",
    "摄影",
    "户外",
    "客服",
    "超级自恋的小哥哥",
    "直播",
    "不忘初心 继续前行",
    "记性不好",
    "花容月貌",
    "榴莲控",
    "一定要穿美美的衣服"
  ];

  List<String> _filters = <String>[];

  Widget _buildItem(int index) {
    String content = list[index];
    return InputChip(
      avatar: CircleAvatar(
        backgroundImage: AssetImage('assets/images/illustration_1.jpg'),
        radius: 12.0,
      ),
      label: Text(
        content,
        style: TextStyle(fontSize: 12.0),
      ),
      shadowColor: Colors.grey,
      deleteIcon: Icon(
        Icons.close,
        color: Colors.black54,
        size: 14.0,
      ),
      onDeleted: () {
        setState(() {
          list.removeAt(index);
        });
      },
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _filters.add(list[index]);
          } else {
            _filters.removeWhere((String name) {
              return name == list[index];
            });
          }
        });
      },
      selectedColor: Colors.orange,
      disabledColor: Colors.grey,
      selected: _filters.contains(list[index]),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      labelStyle: TextStyle(color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InputChipDemo"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 5.0,
          //主轴间距
          runSpacing: 8.0,
          //副轴间距
          alignment: WrapAlignment.end,
          //主轴上的对齐方式
          crossAxisAlignment: WrapCrossAlignment.center,
          //副轴上的对齐方式
          children: List<Widget>.generate(
            list.length,
                (int index) {
              return _buildItem(index);
            },
          ).toList(),
        ),
      ),
    );
  }
}


class FilterChipDemo extends StatefulWidget {
  @override
  _FilterChipDemoState createState() => _FilterChipDemoState();
}

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);

  final String name;
  final String initials;
}

class _FilterChipDemoState extends State<FilterChipDemo> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets sync* {
    for (ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FilterChipDemo"),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: actorWidgets.toList(),
          ),
          Text('Look for: ${_filters.join(', ')}'),
        ],
      ),
    );
  }
}