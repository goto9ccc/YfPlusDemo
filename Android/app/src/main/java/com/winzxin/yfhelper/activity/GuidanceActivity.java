package com.winzxin.yfhelper.activity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.winzxin.yfhelper.R;
import com.winzxin.yfhelper.adapter.GuidancePagerAdapter;
import com.winzxin.yfhelper.utils.ZoomOutPageTransformer;

import java.util.ArrayList;
import java.util.List;

public class GuidanceActivity extends AppCompatActivity implements ViewPager.OnPageChangeListener {


    private ViewPager mViewPager;
    private  Handler handler = new Handler(){
        @Override
        public void handleMessage(Message msg) {
            startActivity(new Intent(GuidanceActivity.this, LoginActivity.class));
            finish();

        }
    };




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SharedPreferences sharedPreferences = getSharedPreferences("yfhelper",MODE_PRIVATE);
        boolean isFirst = sharedPreferences.getBoolean("isFirst", true);
        if (isFirst) {
//            setContentView(R.layout.activity_guidance);
//            mViewPager = (ViewPager) findViewById(R.id.view);
//            //添加动画效果
//            mViewPager.setPageTransformer(true, new ZoomOutPageTransformer());
//            mViewPager.setAdapter(new GuidancePagerAdapter());
//            SharedPreferences.Editor editor =  sharedPreferences.edit();
//            editor.putBoolean("isFirst",false);
//            editor.commit();

            setContentView(R.layout.layout_first);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Thread.sleep(2000);
                        handler.sendEmptyMessage(0x123);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }).start();


        }else{
            setContentView(R.layout.layout_first);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Thread.sleep(2000);
                        handler.sendEmptyMessage(0x123);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        }
    }



    @Override
    public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

    }

    @Override
    public void onPageSelected(int position) {

    }

    @Override
    public void onPageScrollStateChanged(int state) {

    }
}
