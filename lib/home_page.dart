import 'package:assistant/feature_box.dart';
import 'package:assistant/openai_service.dart';
import 'package:assistant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    flutterTts = FlutterTts();
    print('speechToText is called');
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    print('speechToText is called');
    setState(() {});
  }

  Future<void> startListening() async {
    print("startListening called");
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print("Recognized Words: $lastWords");
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: BounceInDown(child: Text('Jarvis')),
        centerTitle: true, //TO BRING TITLE TO CENTRE IRRESPECTIVE OF DEVICE
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // PROFILE PIC
          ZoomIn(
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/assistant.png'))),
            ),
          ),
          //chat bubbles
          FadeInRight(
            child: Visibility(
              visible: generatedImageUrl == null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.borderColor),
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: Radius.zero)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    generatedContent == null
                        ? 'Good Morning, what task can i do for you?'
                        : generatedContent!,
                    style: TextStyle(
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null ? 22 : 18,
                        fontFamily: 'Cera Pro'),
                  ),
                ),
              ),
            ),
          ),

          if (generatedImageUrl != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(generatedImageUrl!)),
            ),

          //title before commands

          SlideInLeft(
            child: Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Here are a few commands',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cera Pro',
                      color: Pallete.mainFontColor,
                      fontSize: 16),
                ),
              ),
            ),
          ),

          //SUGGESTION LIST
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Column(
              children: [
                //CHATGPT
                SlideInLeft(
                  duration: Duration(milliseconds: start),
                  child: const FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: 'ChatGPT',
                    description:
                        'A smarter way to stay organized and informed with ChatGPT',
                  ),
                ),
                //DALLE
                SlideInLeft(
                  duration: Duration(milliseconds: start + delay),
                  child: const FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: 'Dall-E',
                    description:
                        'Get inspired and stay creative with your personal assistant powered by Dall-E',
                  ),
                ),
                //SMART VOICE ASSISTANT
                SlideInLeft(
                  duration: Duration(milliseconds: start + 2 * delay),
                  child: const FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: 'Smart Voice Assistant',
                    description:
                        'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                  ),
                ),
              ],
            ),
          )
        ]),
      ),

      //MIC BUTTON
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
