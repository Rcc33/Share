import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:share/main.dart';

String _envId = 'share-9ggcxivda3a51638';
CloudBaseCore core = CloudBaseCore.init({
  'envId':_envId,
  'env': _envId,
  'appAccess': {'key': 'b56f6d8db5e7904f9a6d7c9a92364a6e', 'version': '1'},
  'timeout': 3000
});

void main() {
  runApp((MaterialApp(
    title: "Navigation basics",
    home: Load(),
  )));
}

class Load extends StatefulWidget {
  @override
  State createState() {
    return MyLoad();
  }
}

class MyLoad extends State<Load> {
  var authState;
  String name = '书籍名字是什么呢~';
  String text = '描述一下这本书籍吧~';
  int sex = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController discribeController = TextEditingController();

  //云数据库
  _addNote() async {
    CloudBaseAuth auth = CloudBaseAuth(core);
    CloudBaseAuthState? authState = await auth.getAuthState();

    //匿名登录
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        print('登陆成功');
      }).catchError((err) {
        // 登录失败
      });
    }
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection book = db.collection("book");
    Collection film = db.collection("film");
    if (sex == 1) {
      book.add({
        "name": titleController.text,
        "discribe": discribeController.text
      });
    } else {
      film.add(
          {"name": titleController.text, "discribe": discribeController.text});
    }
  }
  Future<bool> _requestPop() {
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("发布"),
              backgroundColor: const Color.fromARGB(255, 153, 204, 102),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Column(children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: const Text(
                                  "选择一个类别分享：",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 70, 90, 70),
                                  ),
                                ),
                              ),
                              const Text(
                                "书籍",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 70, 90, 70),
                                ),
                              ),
                              Radio(
                                activeColor:
                                    const Color.fromARGB(255, 153, 204, 102),
                                // 按钮的值
                                value: 1,
                                // 改变事件
                                onChanged: (value) {
                                  setState(() {
                                    sex = 1;
                                    name = '书籍名字是什么呢~';
                                    text = '描述一下这本书籍吧~';
                                  });
                                },
                                // 按钮组的值
                                groupValue: sex,
                              ),
                              const Text(
                                '影视',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 70, 90, 70),
                                ),
                              ),
                              Radio(
                                activeColor:
                                    const Color.fromARGB(255, 153, 204, 102),
                                value: 2,
                                onChanged: (value) {
                                  setState(() {
                                    sex = 2;
                                    name = '电影名字是什么呢~';
                                    text = '评价一下这部电影吧~';
                                  });
                                },
                                groupValue: sex,
                              ),
                            ]),
                            Form(
                                key: _formKey,
                                child: Column(children: <Widget>[
                                  Container(
                                    child: TextFormField(
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      maxLength: 25,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          if (sex == 1) {
                                            return '请输入书籍名';
                                          } else {
                                            return '请输入电影名';
                                          }
                                        }
                                        return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        letterSpacing: 2.0,
                                        color: Color.fromARGB(255, 50, 50, 50),
                                      ),
                                      controller: titleController,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: const Color.fromARGB(
                                          255, 153, 204, 102),
                                      cursorHeight: 22.0,
                                      maxLines: 10,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                        isDense: true,
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Color.fromARGB(
                                                255, 153, 204, 102),
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150),
                                              width: 1.5),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: name,
                                        hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 180, 180),
                                          fontSize: 15,
                                        ),
                                      ),
                                      autofocus: false,
                                    ),
                                    margin: const EdgeInsets.only(
                                        bottom: 40.0, top: 20.0),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 40.0),
                                    child: TextFormField(
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      maxLength: 300,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          if (sex == 1) {
                                            return '请输入书籍描述';
                                          } else {
                                            return '请输入电影描述';
                                          }
                                        }
                                        return null;
                                      },
                                      maxLines: 10,
                                      minLines: 1,
                                      textInputAction: TextInputAction.newline,
                                      autocorrect: false,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      style: const TextStyle(
                                        letterSpacing: 2.0,
                                        fontSize: 15.0,
                                        color: Color.fromARGB(255, 50, 50, 50),
                                      ),
                                      controller: discribeController,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: const Color.fromARGB(
                                          255, 153, 204, 102),
                                      cursorHeight: 22.0,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                        isDense: true,
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Color.fromARGB(
                                                255, 153, 204, 102),
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150),
                                              width: 1.5),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: text,
                                        hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 180, 180),
                                          fontSize: 15,
                                        ),
                                      ),
                                      autofocus: false,
                                    ),
                                  )
                                ])),
                          ],
                        ),
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 153, 204, 102),
                                width: 2.0,
                              )),
                          color: Colors.white,
                          textColor: const Color.fromARGB(255, 153, 204, 102),
                          child: const Text(
                            '发布',
                            style: TextStyle(
                              letterSpacing: 8.0,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _addNote();
                              var snackBar = SnackBar(
                                content: const Text(
                                  '提交成功！',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 70, 90, 70),
                                    letterSpacing: 8.0,
                                    fontSize: 15.0,
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                    bottom: 50.0, left: 105, right: 105.0),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 2000),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Color.fromARGB(255, 153, 204, 102),
                                      width: 1.0,
                                    )),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => MyApp()));
                            }
                          },
                        ),
                      )
                    ])))));
  }
}
