import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String? _code = '';
  String? _stdin = '';
  String _output = '运行结果';

  _formSubmitted() async {
    var _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      //云函数
      //云数据库
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("云开发flutter"),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Text("提交"),
        ),
        body: new SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: new Form(
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  maxLines: null,
                  decoration: new InputDecoration(labelText: '代码'),
                  onSaved: (val) {
                    _code = val;
                  },
                ),
                new TextFormField(
                  maxLines: null,
                  decoration: new InputDecoration(labelText: '标准输入'),
                  onSaved: (val) {
                    _stdin = val;
                  },
                ),
                new Text(_output),
                new MaterialButton(
                  onPressed: null,
                  color: Colors.blue,
                  child: new Text('下载代码'),
                )
              ],
            ),
            key: _formKey,
          ),
        ),
      ),
    );
  }
}
