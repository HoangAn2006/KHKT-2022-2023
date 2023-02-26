import 'package:flutter/material.dart';
import 'home_page.dart';
import 'setting_page.dart';
import 'wconfig_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget MyHome = Home();
  Widget MyWConfig = WConfig();
  Widget MyInfor = Setting();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: getBody(),
      bottomNavigationBar:BottomNavigationBar(
      unselectedItemColor: Colors.grey.withOpacity(1),
      iconSize: 25,
      fixedColor: Colors.black.withOpacity(0.8),
      type:BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      items:[
      BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "Home",
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.wifi_outlined),
      label: "W-Config",
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: "Setting",
      ),
      ],
      onTap: (int index){
      onTapHandler(index);
      },
    ),
    );
  }

  Widget getBody( )  {
    if(selectedIndex == 0) {
      return MyHome;
    } else if(selectedIndex==1){
      return MyWConfig;
    } else {
      return MyInfor;
    }
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }
}


