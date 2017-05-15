# VideoLauncher

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

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
