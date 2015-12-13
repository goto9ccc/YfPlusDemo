
package com.winzxin.yfhelper.utils;

import android.content.Context;
import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.PreviewCallback;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import java.io.IOException;

/** 继承自SurfaceView的基本摄像头预览类  */
public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {
    private SurfaceHolder mHolder;
    private Camera mCamera;
    private PreviewCallback previewCallback;
    private AutoFocusCallback autoFocusCallback;
    /**
     * 传入摄像头实例 预览回调函数和自动对焦回调函数
     * @param context
     * @param camera
     * @param previewCb
     * @param autoFocusCb
     */

    public CameraPreview(Context context, Camera camera,
                         PreviewCallback previewCb,
                         AutoFocusCallback autoFocusCb) {
        super(context);
        mCamera = camera;
        previewCallback = previewCb;
        autoFocusCallback = autoFocusCb;

        // 将SurfaceHolder.Callback挂载到SurfaceHolder
        mHolder = getHolder();
        mHolder.addCallback(this);
        mHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
    }

    public void surfaceCreated(SurfaceHolder holder) {
        // The Surface has been created, now tell the camera where to draw the preview.
        try {
            mCamera.setPreviewDisplay(holder);
        } catch (IOException e) {
        	Log.d("DBG", "启动摄像头预览错误: " + e.getMessage());
        }
    }

    public void surfaceDestroyed(SurfaceHolder holder) {

    }

    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        if (mHolder.getSurface() == null){
          return;
        }
        try {
            mCamera.stopPreview();
        } catch (Exception e){
        }

        try {
            mCamera.setDisplayOrientation(90);
            mCamera.setPreviewDisplay(mHolder);
            mCamera.setPreviewCallback(previewCallback);
            mCamera.startPreview();
            mCamera.autoFocus(autoFocusCallback);
        } catch (Exception e){
            Log.d("DBG", "启动摄像头预览错误: " + e.getMessage());
        }
    }
}
