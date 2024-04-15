import 'package:flutter/material.dart';

import '../DrawerWidget/dwarer_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
         _scaffoldKey.currentState!.openDrawer();
      }, icon: Icon(Icons.menu),),),

      drawer: Drawer(
        backgroundColor: Colors.white,
        width: 250,
        child: DrawerWidget(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),

      ),
    );
  }
}