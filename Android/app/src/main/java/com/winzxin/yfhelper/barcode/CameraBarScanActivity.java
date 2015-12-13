package com.winzxin.yfhelper.barcode;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.PreviewCallback;
import android.hardware.Camera.Size;
import android.os.Bundle;
import android.os.Handler;
import android.view.animation.Animation;
import android.view.animation.LinearInterpolator;
import android.view.animation.TranslateAnimation;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.winzxin.yfhelper.R;
import com.winzxin.yfhelper.utils.CameraPreview;

import net.sourceforge.zbar.Config;
import net.sourceforge.zbar.Image;
import net.sourceforge.zbar.ImageScanner;
import net.sourceforge.zbar.Symbol;
import net.sourceforge.zbar.SymbolSet;


/* 导入 ZBar Class 文件 */

public class CameraBarScanActivity extends Activity {
    private Camera mCamera;
    private CameraPreview mPreview;
    private Handler autoFocusHandler;
    TextView scanText;
    ImageScanner scanner;

    private RelativeLayout mContainer = null;
    private RelativeLayout mCropLayout = null;
    //private boolean barcodeScanned = false;  //连续扫描
    private boolean previewing = true;

    static {
        System.loadLibrary("iconv");
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_barcode);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        autoFocusHandler = new Handler();
        mCamera = getCameraInstance();
        /* 实例化条码扫描器 */
        scanner = new ImageScanner();
        scanner.setConfig(0, Config.X_DENSITY, 3);
        scanner.setConfig(0, Config.Y_DENSITY, 3);
        mPreview = new CameraPreview(this, mCamera, previewCb, autoFocusCB);
        FrameLayout preview = (FrameLayout) findViewById(R.id.cameraPreview);
        preview.addView(mPreview);
        scanText = (TextView) findViewById(R.id.scanText);

        mContainer = (RelativeLayout) findViewById(R.id.capture_containter);
        mCropLayout = (RelativeLayout) findViewById(R.id.capture_crop_layout);

        ImageView mQrLineView = (ImageView) findViewById(R.id.capture_scan_line);
        TranslateAnimation mAnimation = new TranslateAnimation(TranslateAnimation.ABSOLUTE, 0f, TranslateAnimation.ABSOLUTE, 0f,
                TranslateAnimation.RELATIVE_TO_PARENT, 0f, TranslateAnimation.RELATIVE_TO_PARENT, 0.9f);
        mAnimation.setDuration(1500);
        mAnimation.setRepeatCount(-1);
        mAnimation.setRepeatMode(Animation.REVERSE);
        mAnimation.setInterpolator(new LinearInterpolator());
        mQrLineView.setAnimation(mAnimation);

    }

    public void onPause() {
        super.onPause();
        releaseCamera();
    }

    /**
     * 获得相机实例的安全方法
     */
    public static Camera getCameraInstance() {
        Camera c = null;
        try {
            c = Camera.open();
        } catch (Exception e) {
        }
        return c;
    }

    private void releaseCamera() {
        if (mCamera != null) {
            previewing = false;
            mCamera.setPreviewCallback(null);
            mCamera.release();
            mCamera = null;
        }
    }

    /**
     * 线程运行对象 自动对焦
     */

    private Runnable doAutoFocus = new Runnable() {
        public void run() {
            if (previewing)
                mCamera.autoFocus(autoFocusCB);
        }
    };

    /**
     * 回调函数中处理条码事件 获得条码返回
     */
    PreviewCallback previewCb = new PreviewCallback() {
        public void onPreviewFrame(byte[] data, Camera camera) {
            Camera.Parameters parameters = camera.getParameters();
            Size size = parameters.getPreviewSize();
            Image barcode = new Image(size.width, size.height, "Y800");
            barcode.setData(data);
            int result = scanner.scanImage(barcode);
            if (result != 0) {
                previewing = false;
                mCamera.setPreviewCallback(null);
                mCamera.stopPreview();
                SymbolSet syms = scanner.getResults();
                for (Symbol sym : syms) {
                    /**
                     * 在这里处理返回事件，并结束Activity
                     */
                    //scanText.setText("条码返回值：" + sym.getData());
                    Intent intent = getIntent();
                    intent.putExtra("barcode", sym.getData());
                    setResult(RESULT_OK, intent);
                    //barcodeScanned = true;
                    finish();
                }
            }
        }
    };

    // 连续自动对焦 在线程中每秒执行一次
    AutoFocusCallback autoFocusCB = new AutoFocusCallback() {
        public void onAutoFocus(boolean success, Camera camera) {
            autoFocusHandler.postDelayed(doAutoFocus, 1000);
        }
    };
}
