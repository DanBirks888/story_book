import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:story_book/data.dart';

class StoryBook extends StatefulWidget {
  const StoryBook({super.key});

  @override
  StoryBookState createState() => StoryBookState();
}

class StoryBookState extends State<StoryBook> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StoryBookData.getTitle()),
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: TabBar(
            onTap: (nar) {
              StoryBookData.narrateAP.stop();
              StoryBookData.newNarrator(nar);
              StoryBookData.narrate(StoryBookData.currentPage);
            },
            tabs: [
              Tab(icon: Image.asset(StoryBookData.narrDir(N.narrator_1))),
              Tab(icon: Image.asset(StoryBookData.narrDir(N.narrator_2))),
              Tab(icon: Image.asset(StoryBookData.narrDir(N.narrator_3))),
            ],
          ),
        ),
        body: const Pages(),
      ),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StoryBookData.fullNovel(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<String>> snapshot,
      ) =>
          PageView(
        children: StoryBookData.renderAllPages(snapshot.data!),
      ),
    );
  }
}

class SinglePage extends StatelessWidget {
  final N narrator;
  final String storyLine;
  final int index;

  const SinglePage({
    required this.narrator,
    required this.index,
    required this.storyLine,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoryBookData.narrate(index);
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: StoryLine(line: storyLine),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StoryBookData.img(index),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class StoryLine extends StatefulWidget {
  final String line;
  const StoryLine({
    required this.line,
    super.key,
  });

  @override
  _StoryLineState createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(widget.line,
            textAlign: TextAlign.center,
            duration: const Duration(seconds: 5),
            fadeInEnd: 1.0,
            fadeOutBegin: 5.0,
            textStyle: const TextStyle(
              color: Colors.white,
              height: 2,
              fontFamily: 'Times New Roman',
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ))
      ],
      totalRepeatCount: 1,
    );
  }
}
