# VideoLauncher

## Example

```bash
cd flutter_video_launcher/example
flutter packages get
flutter run
```

![screenshot](https://github.com/rxlabz/flutter_video_launcher/blob/master/screenshot.png)

## Usage

To use this plugin, add video_launcher as a dependency in your pubspec.yaml file.

After importing 'package:video_launcher/video_launcher.dart' the directories can be queried as follows

## Remote video

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

## Local video

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

## Embedded asset

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

Please see the example app of this plugin for a full example.


## :warning: iOS App Transport Security

By default iOS forbids loading from non-https url. To cancel this restriction edit your .plist and add :
 
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

cf. [Configuring App Transport Security Exceptions in iOS](https://ste.vn/2015/06/10/configuring-app-transport-security-ios-9-osx-10-11/)

## Troubleshooting

If you get a MissingPluginException, try to `flutter build apk` on Android, or `flutter build ios`

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
    