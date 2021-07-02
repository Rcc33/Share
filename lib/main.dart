import 'package:flutter/material.dart';
import 'upload.dart';
import 'movie.dart';
import 'book.dart';

Future<void> main() async {
  runApp((MaterialApp(
    title: "Navigation basics",
    home: MyApp(),
  )));
}

class MyApp extends StatefulWidget {

  @override
  State createState() {
    return MyAppState();
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  int currentIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var pages = [Book(), Movie()];

  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      currentIndex = 0;
      pages = [Book(), Movie()];
    });
    super.initState();
  }

  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Icon(
        Icons.book_outlined,
        //color: Color.fromARGB(255, 153, 204, 102),
      ),
      label: "书籍",
    ),
    const BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Icon(
        Icons.movie_creation_outlined,
        //color: Color.fromARGB(255, 153, 204, 102),
      ),
      label: "影视",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("DailyShare"),
          backgroundColor: const Color.fromARGB(255, 153, 204, 102),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Load()));
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 153, 204, 102),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            FloatingActionButtonLocation.endDocked, -5, -45),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8.0,
          fixedColor: const Color.fromARGB(255, 153, 204, 102),
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
