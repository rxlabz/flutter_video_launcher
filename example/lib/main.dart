import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_launcher/video_launcher.dart';

void main() {
  runApp(new MyApp());
}

const videoUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";

/// a video launcher, based on url_launcher
/// can read remote and local files
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Video Launcher',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Video Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Null> _launched;

  void _launchUrl() {
    setState(() {
      _launched = _launchVideo(videoUrl);
    });
  }

  Future<Null> _launchVideo(String url) async {
    if (await canLaunchVideo(url)) {
      await launchVideo(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return new Text('Error: ${snapshot.error}');
    } else {
      return const Text('Video launched');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Padding(
                  padding: new EdgeInsets.all(16.0),
                  child: new Text(videoUrl),
                ),
                new RaisedButton(
                  onPressed: _launchUrl,
                  child: new Text('Go'),
                ),
              ],
            ),
            new FutureBuilder<Null>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }
}
