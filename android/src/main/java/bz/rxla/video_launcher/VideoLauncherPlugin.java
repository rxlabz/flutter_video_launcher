package bz.rxla.video_launcher;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.io.File;
import java.util.HashMap;


/**
 * VideoLauncherPlugin
 */
public class VideoLauncherPlugin implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel =
                new MethodChannel(registrar.messenger(), "bz.rxla.flutter/video_launcher");
        VideoLauncherPlugin instance = new VideoLauncherPlugin(registrar.activity());
        channel.setMethodCallHandler(instance);
    }

    private VideoLauncherPlugin(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        String url = ((HashMap) call.arguments()).get("url").toString();
        Boolean isLocal = ((HashMap) call.arguments()).get("isLocal").toString() == "1";
        if (call.method.equals("canLaunchVideo")) {
            canLaunchVideo(url, result, isLocal);
        } else if (call.method.equals("launchVideo")) {
            launchURLVideo(url, result, isLocal);
        } else {
            result.notImplemented();
        }
    }

    private void launchURLVideo(String url, MethodChannel.Result result, Boolean isLocal) {
        if( isLocal ){
            File f = new File(url);
            f.setReadable(true, false);
            Uri videoUri = Uri.fromFile(f);
            Intent launchIntent = new Intent(Intent.ACTION_VIEW);
            launchIntent.setDataAndType(Uri.parse(videoUri.toString()), "video/mp4");
            activity.startActivity(launchIntent);
            result.success(null);
        } else {
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
            intent.setDataAndType(Uri.parse(url), "video/mp4");
            activity.startActivity(intent);
            result.success(null);
        }
    }

    private void canLaunchVideo(String url, MethodChannel.Result result, Boolean isLocal) {
        boolean canLaunch;

        if (isLocal) {
            File f = new File(url);
            f.setReadable(true, false);
            Uri videoUri = Uri.fromFile(f);
            Intent launchIntent = new Intent(Intent.ACTION_VIEW);
            launchIntent.setDataAndType(Uri.parse(videoUri.toString()), "video/mp4");
            ComponentName componentName = launchIntent.resolveActivity(activity.getPackageManager());
            canLaunch = componentName != null
                    && !"{com.android.fallback/com.android.fallback.Fallback}"
                    .equals(componentName.toShortString());
        } else {
            Intent launchIntent = new Intent(Intent.ACTION_VIEW);
            launchIntent.setDataAndType(Uri.parse(url), "video/mp4");
            ComponentName componentName = launchIntent.resolveActivity(activity.getPackageManager());
            canLaunch = componentName != null
                    && !"{com.android.fallback/com.android.fallback.Fallback}"
                    .equals(componentName.toShortString());
        }
        result.success(canLaunch);
    }
}
