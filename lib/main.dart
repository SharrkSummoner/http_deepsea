import 'package:flutter/material.dart';

import 'hullBlock.dart';
import 'parse.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const Home(),
        '/rest': (BuildContext context) => const MyStatefulWidget(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget body = Text("meow");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("rest"),
      ),
      body: Center(
        child: Container(child: body,),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(child: DrawerHeader(child: Container(),),),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Rest"),
                    leading: Icon(Icons.api),
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        body = MyStatefulWidget();
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Another"),
                    leading: Icon(Icons.hourglass_full),
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        body = Text("space");
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  );

  Widget buildItems(BuildContext context) => Column(
    children: [
      ListTile(
        title: Text("Rest"),
        leading: Icon(Icons.api),
        onTap: () {
          setState(() {
            body = ListTile();
          });
        },
      ),
      ListTile(
        title: Text("Another"),
        leading: Icon(Icons.hourglass_full),
        onTap: () {
          setState(() {
            body = HullBlocks();
          });
        },
      )
    ],
  );
}


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ListElements(),
    HullBlocks()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_full),
            label: 'HullBlocks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildItems(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text("Rest"),
            leading: Icon(Icons.api),
            onTap: () {

            },
          ),
          ListTile(
            title: Text("Another"),
            leading: Icon(Icons.hourglass_full),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HullBlocks()));
            },
          )
        ],
      );
}

class ListElements extends StatefulWidget {
  const ListElements({Key? key}) : super(key: key);

  @override
  State<ListElements> createState() => _ListElementsState();
}

class _ListElementsState extends State<ListElements> {
  List<ProjectName> futureProjectName = List<ProjectName>.empty(growable: true);

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchProjects().then((value) => {
          setState(() {
            value.forEach((element) {
              futureProjectName.add(element);
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(selectedIndex == -1
            ? "NO"
            : "id: ${futureProjectName[selectedIndex].id}\n"
                "rkd: ${futureProjectName[selectedIndex].rkd}\n"
                "pdsp: ${futureProjectName[selectedIndex].pdsp}\n"
                "foran: ${futureProjectName[selectedIndex].foran}\n"
                "cloud: ${futureProjectName[selectedIndex].cloud}\n"
                "cloudRkd: ${futureProjectName[selectedIndex].cloudRkd}\n"),
        Expanded(
            child: ListView.builder(
          itemBuilder: _createListView,
          itemCount: futureProjectName.length,
        ))
      ],
    );
  }

  Widget _createListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 8),
        color: index == selectedIndex ? Colors.black12 : Colors.white60,
        child: Text(futureProjectName[index].foran,
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class HullBlocks extends StatefulWidget {
  const HullBlocks({Key? key}) : super(key: key);

  @override
  State<HullBlocks> createState() => _HullBlocksState();
}

class _HullBlocksState extends State<HullBlocks> {
  List<Code> futureCode = List<Code>.empty(growable: true);

  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCode().then((value) => {
          setState(() {
            value.forEach((element) {
              futureCode.add(element);
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(selectedIndex == -1
            ? "NO"
            : "OID: ${futureCode[selectedIndex].oid}\n"
                "CODE: ${futureCode[selectedIndex].code}\n"
                "DESCRIPTION: ${futureCode[selectedIndex].description}\n"),
        Expanded(
            child: ListView.builder(
          itemBuilder: _createListView,
          itemCount: futureCode.length,
        ))
      ],
    );
  }

  Widget _createListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 8),
        color: index == selectedIndex ? Colors.black12 : Colors.white60,
        child: Text(futureCode[index].code, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
