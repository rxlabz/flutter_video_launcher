# VideoLauncher

![screenshot](https://www.github.com/rxlabz/flutter_video_launcher/screenshot.png)

## Usage

To use this plugin, add video_launcher as a dependency in your pubspec.yaml file.

## Example

After importing 'package:video_launcher/video_launcher.dart' the directories can be queried as follows

To launch a video :

```dart
Future<Null> _launch(String url) async {
    if (await canLaunchVideo(url)) {
      await launchVideo(url);
    } else {
      throw 'Could not launch $url';
    }
  }
```

To play a local video file :

```dart
Future<Null> _launch(String url) async {
    if (await canLaunchVideo(url, isLocal:true)) {
      await launchVideo(url, isLocal:true);
    } else {
      throw 'Could not launch $url';
    }
  }
```

Please see the example app of this plugin for a full example.

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
    