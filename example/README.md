# Video Launcher example

```bash
cd flutter_video_launcher/example
flutter packages get
flutter run
```

## Remote

```dart
void _launch() => setState(() => _launched = _launchVideo(videoUrl));
```

## local

```dart
void _launchLocal() =>
  setState(() => _launched = _launchVideo(localVideoPath, isLocal: true));
```

## asset

To play video embedded assets, you can copy them to the app storage folder, and the play them "locally"

```dart
void _loadOrLaunchLocalAsset() =>
      localAssetPath != null ? _launchLocalAsset() : copyLocalAsset();

Future copyLocalAsset() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = new File("${dir.path}/video_asset.mp4");
  final videoData = await rootBundle.load("assets/video.mp4");
  final bytes = videoData.buffer.asUint8List();
  file.writeAsBytes(bytes, flush: true);
    setState(() {
    localAssetPath = file.path;
    _launchLocalAsset();
});
}

void _launchLocalAsset() =>
  setState(() => _launched = _launchVideo(localAssetPath, isLocal: true));
```

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
    