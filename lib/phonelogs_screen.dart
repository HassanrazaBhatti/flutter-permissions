import 'package:flutter/material.dart';


class PhonelogsScreen extends StatefulWidget {
  @override
  _PhonelogsScreenState createState() => _PhonelogsScreenState();
}

class _PhonelogsScreenState extends State<PhonelogsScreen> with  WidgetsBindingObserver {
  //Iterable<CallLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone"),),
      body: Center(
      child: Text("Hello MicroPhone"),
      )
    );
  }
}