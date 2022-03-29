# do_touch

A flutter plugin to touch and perform swipe on screen using accessibility service. This plugin was designed to go in sync with [Auto Join](https://github.com/princesanjivy/auto-join) app.

## Usage

To use this plugin, add `do_touch` as a dependency in your `pubspec.yaml` .

## Configuration
### Android

Also add this service tag in your `AndroidManifest.xml` file.

```
<service android:name="com.example.do_touch.MyAccessibilityService"
    android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE"
    android:label="Auto Join"
    android:exported="true">
    <intent-filter>
        <action android:name="android.accessibilityservice.AccessibilityService" />
    </intent-filter>
    <meta-data
        android:name="android.accessibilityservice"
        android:resource="@xml/accessibility_service_config" />
</service>
```

## Methods

`DoTouch.screenOn` - To check whether the screen is turned on or not.

`DoTouch.isDeviceLocked` - To check whether the screen is locked or not.

`isAccessibilityGranted` - Checks if accessibikity permission is granted.

if not `getPermission` use this to navigate user to the consent screen.

## Example

```
import 'package:do_touch/do_touch.dart';

await DoTouch.touchPoint(
    x: 100,
    y: 100,
    canSwipe: false,
);
```

For more detailed example see [here](https://github.com/princesanjivy/do-touch/blob/master/example/lib)

`touchPoint` method takes 3 properties `x` - x co-ordinate point of the screen, `y` - y co-ordinate point of the screen, `canSwipe` - boolean whether to swipe from up from that point (As of now only swipe up is implemented).

## Pull Requests

I welcome contributors to enchance this plugin. Also feel free to throw some issues if you find one. 

Cheers!