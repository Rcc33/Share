import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'note.dart';

String _envId = 'share-9ggcxivda3a51638';
CloudBaseCore core = CloudBaseCore.init({
  'envId':_envId,
  'env': _envId,
  'appAccess': {'key': 'b56f6d8db5e7904f9a6d7c9a92364a6e', 'version': '1'},
  'timeout': 3000
});
List formList = [];
var cn;


class Book extends StatefulWidget {
  Book() {
    getList();
  }

  @override
  State createState() {
    return MyBook();
  }
}

Future<void> getList() async {
  CloudBaseAuth auth = CloudBaseAuth(core);
  CloudBaseAuthState? authState = await auth.getAuthState();

  print(authState);
  //匿名登录
  if (authState == null) {
    await auth.signInAnonymously().then((success) {
    }).catchError((err) {
      throw(err);
    });
  }
  CloudBaseDatabase db = CloudBaseDatabase(core);
  Collection book = db.collection("book");
  await book.where({}).get().then((res) {
        formList = res.data;
      });
}

Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  getList();
  for (var item in formList) {
    tiles.add(
      InkWell(
        //单击事件响应
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Note(item)));
        },
        child: Container(
          width: double.infinity,
          height: 120.0,
          margin: const EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: const Color.fromARGB(255, 210, 225, 210),
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            shape: BoxShape.rectangle,
          ),
          child: Container(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    item['name'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 70, 90, 70),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(),
                  child: Text(
                    item['discribe'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 70, 90, 70),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  content = SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: Column(
        children: tiles,
      ),
    ),
  );
  return content;
}

class MyBook extends State<Book> {
  var ExampleWidget;

  @override
  Widget build(BuildContext context) {
    cn = context;
    ExampleWidget = buildGrid(cn);
    return Scaffold(body: Container(child: ExampleWidget));
  }
}
