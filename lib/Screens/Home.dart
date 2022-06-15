import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    List<String> page = ["Login","Home","Pages"];

    return Scaffold(
      appBar: AppBar(
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              tapText("P1", context),
              tapText("P2", context),
              tapText("P3", context),
            ],
          ),
        ),
      ),
      body: const Center(
        child: SizedBox(
          height: 80,
          width: 100,
          child: Text(
              "Home Page",
              textScaleFactor: 2,
              textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios),
            label: 'Login',
           // activeIcon: Container(child: GestureDetector(onTap: (){Navigator.pushNamed(context, "Login");},))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
              //activeIcon: Container(child: GestureDetector(onTap: (){Navigator.pushNamed(context, "Home");},))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios),
            label: 'Page',
             // activeIcon: Container(child: GestureDetector(onTap: (){Navigator.pushNamed(context, "Pages");},))
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;

          });
          (index>1)?Navigator.pushNamed(context, page[index]):Navigator.popAndPushNamed(context, page[index]);
        },
      ),
    );
  }
}

Widget tapText(String s,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ListTile(
      title: Text(s,textScaleFactor: 2),
      hoverColor: Colors.amberAccent,
      onTap: (){Navigator.pushNamed(context, "Pages");},
      tileColor: Colors.teal,
    )
  );
}