import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  SVGAAnimationController? animationController;

  @override
  void initState() {
    animationController = SVGAAnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void play() async {
    final videoItem =
        await SVGAParser.shared.decodeFromAssets("assets/angel.svga");
    final audioItem = await AudioPlayer().play(AssetSource('tone.mp3'));
    animationController?.videoItem = videoItem;
    animationController?.reset();
    animationController?.forward();
    animationController
        ?.forward()
        .whenComplete(() => animationController?.videoItem = null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          Center(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      play();
                    },
                    icon: Icon(Icons.ac_unit)),
              ],
            ),
          ),
          Container(
              child: SVGAImage(
            filterQuality: FilterQuality.high,
            allowDrawingOverflow: true,
            animationController!,
          ))
        ]),
      ),
    );
  }
}
