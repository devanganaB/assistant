import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Jarvis'),
        centerTitle: true, //TO BRING TITLE TO CENTRE IRRESPECTIVE OF DEVICE
      ),
      body: Column(children: [
        // PROFILE PIC
        Container(
          height: 120,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/assistant.png'))),
        ),
        //chat bubbles
      ]),
    );
  }
}
