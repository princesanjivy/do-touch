package com.example.do_touch;

import android.accessibilityservice.AccessibilityService;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.accessibilityservice.GestureDescription;
import android.content.Intent;
import android.graphics.Path;
import android.os.Build;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;

import androidx.annotation.RequiresApi;

public class MyAccessibilityService extends AccessibilityService {

    @Override
    public void onAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
    }

    @Override
    public void onInterrupt() {
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        super.onStartCommand(intent, flags, startId);

        if (intent.getExtras().containsKey("position") && intent.getExtras().containsKey("canSwipe")) {
            Log.d("TAG", "INTENT");
            float[] position = intent.getFloatArrayExtra("position");

            doTouch(position[0], position[1], intent.getBooleanExtra("canSwipe", false));
        }

        return START_STICKY;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private void doTouch(float x, float y, boolean canSwipe) {

        GestureDescription.Builder gestureBuilder = new GestureDescription.Builder();
        Path path = new Path();

        if (canSwipe) {
            path.moveTo(x, y);
            path.lineTo(x, y - 500);
        } else {
            path.moveTo(x, y);
        }

        gestureBuilder.addStroke(new GestureDescription.StrokeDescription(path, 0, 100, false));
        dispatchGesture(gestureBuilder.build(), new GestureResultCallback() {
            @Override
            public void onCancelled(GestureDescription gestureDescription) {
                super.onCancelled(gestureDescription);
                Log.d("TAG", "Gesture Cancelled");
            }

            @Override
            public void onCompleted(GestureDescription gestureDescription) {
                super.onCompleted(gestureDescription);
                Log.d("TAG", "Gesture Completed");
            }
        }, null);
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();

        AccessibilityServiceInfo info = getServiceInfo();
        info.flags = AccessibilityServiceInfo.FLAG_REQUEST_TOUCH_EXPLORATION_MODE;
        info.flags = AccessibilityServiceInfo.FLAG_REQUEST_MULTI_FINGER_GESTURES;

        setServiceInfo(info);
    }
}
