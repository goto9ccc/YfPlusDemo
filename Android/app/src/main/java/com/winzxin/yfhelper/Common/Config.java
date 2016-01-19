package com.winzxin.yfhelper.common;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by song on 2015/11/23.

 */
public class Config {
    private static Config ourInstance;
    private  Context mContext;

    public String getmServerUrl() {

        return mServerUrl;
    }

    public void setmServerUrl(String mServerUrl) {

        this.mServerUrl = mServerUrl;
        SharedPreferences sharedPreferences =
                mContext.getSharedPreferences("config", Application.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString("address",mServerUrl);
        editor.commit();
    }

    private String mServerUrl;

    public static Config getInstance(Context context) {
        if (ourInstance == null) {
            ourInstance = new Config(context);
        }
        return ourInstance;
    }

    private Config(Context context) {
        this.mContext = context;
        SharedPreferences sharedPreferences = context.getSharedPreferences("config", Application.MODE_PRIVATE);
        mServerUrl = sharedPreferences.getString("address", "http://192.168.1.1");
    }
}
