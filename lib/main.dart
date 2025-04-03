import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email App',
      theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade800),

      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade800, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedindex = 0;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(

        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: [

          ],
        ),
      );

  }
}

class NavigationDrawer extends StatelessWidget{

  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
      child: ListView(
        children: [

        ],
      ),
  );



}

