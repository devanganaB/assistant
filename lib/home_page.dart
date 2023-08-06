import 'package:assistant/feature_box.dart';
import 'package:assistant/pallete.dart';
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
          decoration: BoxDecoration(
              border: Border.all(color: Pallete.borderColor),
              borderRadius:
                  BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Good Morning, what task can i do for you?',
              style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 22,
                  fontFamily: 'Cera Pro'),
            ),
          ),
        ),

        //title before commands

        Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.centerLeft,
          child: Text(
            'Here are a few commands',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cera Pro',
                color: Pallete.mainFontColor,
                fontSize: 16),
          ),
        ),

        //SUGGESTION LIST
        const Column(
          children: [
            //CHATGPT
            FeatureBox(
              color: Pallete.firstSuggestionBoxColor,
              headerText: 'ChatGPT',
              description:
                  'A smarter way to stay organized and informed with ChatGPT',
            ),
            //DALLE
            FeatureBox(
              color: Pallete.secondSuggestionBoxColor,
              headerText: 'Dall-E',
              description:
                  'Get inspired and stay creative with your personal assistant powered by Dall-E',
            ),
            //SMART VOIVE ASSISTANT
            FeatureBox(
              color: Pallete.thirdSuggestionBoxColor,
              headerText: 'Smart Voice Assistant',
              description:
                  'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
            ),
          ],
        )
      ]),

      //MIC BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.mic),
      ),
    );
  }
}
