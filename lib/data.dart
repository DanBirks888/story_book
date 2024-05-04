import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:story_book/story_book.dart';

enum N { narrator_1, narrator_2, narrator_3 }

enum Story { story_1, story_2, story_3 }

class StoryBookData {
  static N currentNarrator = N.narrator_1;
  static Story currentStory = Story.story_1;
  static String soundPath = 'assets/audio';
  static String imagePath = 'assets/images';
  static String storyPath = 'assets/story';
  static String soundStoryPath = 'assets/audio/${currentStory.name}';
  static String imgStoryPath = 'assets/images/${currentStory.name}';
  static int currentPage = 0;
  static AudioPlayer narrateAP = AudioPlayer();
  static AudioPlayer themeAP = AudioPlayer();

  static final StoryBookData _storyData = StoryBookData._internal();
  factory StoryBookData() => _storyData;
  StoryBookData._internal();

  // Generic Util
  static String getTitle() {
    switch (currentNarrator) {
      case N.narrator_1:
        return 'Narrator 1';
      case N.narrator_2:
        return 'Narrator 2';
      case N.narrator_3:
        return 'Narrator 3';
    }
  }

  static newNarrator(int index) {
    switch (index) {
      case 0:
        return currentNarrator = N.narrator_1;
      case 1:
        return currentNarrator = N.narrator_2;
      case 2:
        return currentNarrator = N.narrator_3;
    }
  }

  static setupStory(N narrator) {
    currentNarrator = narrator;
    switch (narrator) {
      case N.narrator_1:
        currentStory = Story.story_1;
        soundStoryPath = '$soundPath/${currentStory.name}';
        imgStoryPath = '$imagePath/${currentStory.name}';
        break;
      case N.narrator_2:
        currentStory = Story.story_2;
        soundStoryPath = '$soundPath/${currentStory.name}';
        imgStoryPath = '$imagePath/${currentStory.name}';
        break;
      case N.narrator_3:
        currentStory = Story.story_3;
        soundStoryPath = '$soundPath/${currentStory.name}';
        imgStoryPath = '$imagePath/${currentStory.name}';
        break;
    }
  }

  // Image Handling
  static String narrDir(N narrator) => 'assets/images/${narrator.name}.png';
  static AssetImage narratorImg(N narrator) =>
      AssetImage('assets/images/${narrator.name}.png');
  static Image img(int i) => Image.asset('$imgStoryPath/image_$i.png');

  // Audio Handling
  static play(String audio) async => _play('$soundPath/$audio.mp3');
  static narrate(int index) async {
    StoryBookData.narrateAP.stop();
    currentPage = index;
    _play('$soundStoryPath/${currentNarrator.name}_$index.mp3');
  }

  static event(String audio) async => _play(audio);

  static _play(String path) async {
    ByteData b = await rootBundle.load(path);
    narrateAP.playBytes(b.buffer.asUint8List(
      b.offsetInBytes,
      b.lengthInBytes,
    ));
  }

  // Story Handling
  static Future<List<String>> fullNovel() async {
    return const LineSplitter().convert(
        await rootBundle.loadString('$storyPath/${currentStory.name}.txt'));
  }

  static Future<String> novel(int i) async {
    return const LineSplitter().convert(
      await rootBundle.loadString('$storyPath/${currentStory.name}.txt'),
    )[i];
  }

  static List<SinglePage> renderAllPages(List<String> listy) {
    List<SinglePage> pages = [];
    listy.asMap().forEach((key, value) {
      pages.add(SinglePage(
        narrator: StoryBookData.currentNarrator,
        index: key,
        storyLine: value,
      ));
    });
    return pages;
  }
}
