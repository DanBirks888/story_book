import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:story_book/data.dart';
import 'package:story_book/story_book.dart';

void main() => runApp(const StoryBookApp());

class StoryBookApp extends StatefulWidget {
  const StoryBookApp({super.key});

  @override
  _StoryBookAppState createState() => _StoryBookAppState();
}

class _StoryBookAppState extends State<StoryBookApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextLiquidFill(
              loadDuration: const Duration(seconds: 15),
              text: 'Story Book',
              textAlign: TextAlign.center,
              waveColor: Colors.white,
              boxBackgroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.black,
            child: const Center(
                child: Padding(
              padding: EdgeInsets.all(40.0),
              child: HomePageButtons(),
            ))),
      ),
    );
  }
}

class HomePageButtons extends StatefulWidget {
  const HomePageButtons({super.key});

  @override
  _HomePageButtonsState createState() => _HomePageButtonsState();
}

class _HomePageButtonsState extends State<HomePageButtons> {
  @override
  Widget build(BuildContext context) {
    StoryBookData.narrateAP.stop();
    return const Column(
      children: [
        Flexible(child: Narrator(narrator: N.narrator_1)),
        Flexible(child: Narrator(narrator: N.narrator_2)),
        Flexible(child: Narrator(narrator: N.narrator_3)),
      ],
    );
  }
}

class Narrator extends StatefulWidget {
  final N narrator;
  const Narrator({
    required this.narrator,
    super.key,
  });

  @override
  _NarratorState createState() => _NarratorState();
}

class _NarratorState extends State<Narrator> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        StoryBookData.setupStory(widget.narrator);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StoryBook(),
          ),
        );
      },
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: StoryBookData.narratorImg(widget.narrator),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
