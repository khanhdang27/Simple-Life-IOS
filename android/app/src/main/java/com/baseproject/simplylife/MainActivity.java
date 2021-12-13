package com.baseproject.simplylife;

import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

public class MainActivity extends FlutterActivity {

    private static final String CENSOR_TEM_CHANNEL = "com.baseproject.simplylife/censor";
    private EventChannel tempEventChannel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        this.tempEventChannel = new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CENSOR_TEM_CHANNEL);
        this.tempEventChannel.setStreamHandler(new TemperatureCensor((SensorManager) getSystemService(SENSOR_SERVICE)));
    }

    @Override
    protected void onDestroy() {
        this.tempEventChannel.setStreamHandler(null);
        super.onDestroy();
    }
}
