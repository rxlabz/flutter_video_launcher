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

## Troubleshooting

### Android

If you get a MissingPluginException, try to `flutter build apk` on Android, or `flutter build ios`

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

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
    