#import "VideoLauncherPlugin.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation VideoLauncherPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel =
            [FlutterMethodChannel methodChannelWithName:@"bz.rxla.flutter/video_launcher"
                                        binaryMessenger:registrar.messenger];
    [channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSString *url = call.arguments[@"url"];
        BOOL isLocal = call.arguments[@"isLocal"] == @1;

        if ([@"canLaunchVideo" isEqualToString:call.method]) {
            result(isLocal ? @([self fileExists:url]) : @([self canLaunchURLVideo:url]));
        } else if ([@"launchVideo" isEqualToString:call.method]) {
            [self launchURLVideo:url result:result isLocal:isLocal];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

+ (BOOL)fileExists:(NSString *)pathString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:pathString];
}

+ (BOOL)canLaunchURLVideo:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *application = [UIApplication sharedApplication];
    return [application canOpenURL:url];
}

+ (void)launchURLVideo:(NSString *)urlString result:(FlutterResult)result isLocal:(BOOL)isLocal {
    NSURL *url = isLocal ? [NSURL fileURLWithPath:urlString] : [NSURL URLWithString:urlString];

    AVPlayer *player = [AVPlayer playerWithURL:url];

    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.showsPlaybackControls = YES;
    playerViewController.player = player;

    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController.view addSubview:playerViewController.view];
    [viewController presentViewController:playerViewController animated:YES completion:nil];

    [player play];

// Using ifdef as workaround to support running with Xcode 7.0 and sdk version 9
// where the dynamic check fails.
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_9_0
    [application openURL:url
        options:@{}
        completionHandler:^(BOOL success) {
          [self sendResult:success result:result url:url];
        }];
#else
    [self sendResult:YES result:result url:url];
#endif
}

+ (void)sendResult:(BOOL)success result:(FlutterResult)result url:(NSURL *)url {
    if (success) {
        result(nil);
    } else {
        result([FlutterError errorWithCode:@"Error"
                                   message:[NSString stringWithFormat:@"Error while launching %@", url]
                                   details:nil]);
    }
}

@end
