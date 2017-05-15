import 'dart:async';

import 'package:flutter/services.dart';

const _channel = const MethodChannel('bz.rxla.flutter/video_launcher');

/// Parses the specified video URL string and delegates handling of it to the
/// underlying platform.
///
/// The returned future completes with a [PlatformException] on invalid URLs and
/// schemes which cannot be handled, that is when [canLaunchVideo] would complete
/// with false.
Future<Null> launchVideo(String urlString, {bool isLocal:false}) {
  return _channel.invokeMethod(
    /* FIXME had some trouble to send a false BOOL to objC => for now I send 1 || 0 */
    'launchVideo',{"url":urlString, "isLocal":isLocal ? 1 : 0 },
  );
}

/// Checks whether the specified video URL can be handled by some app installed on the
/// device.
Future<bool> canLaunchVideo(String urlString, {bool isLocal:false}) async {
  if (urlString == null) return false;
  return await _channel.invokeMethod(
    'canLaunchVideo',{"url":urlString, "isLocal":isLocal ? 1 : 0}
  );
}
