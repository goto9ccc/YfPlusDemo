package com.winzxin.yfhelper.adapter;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.winzxin.yfhelper.R;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by song on 2015/11/23.
 */
public class OrderAdapter extends BaseAdapter {

    private ArrayList<HashMap<String,String>> mData;

    public OrderAdapter(ArrayList<HashMap<String,String>> data){
        this.mData = data;
    }

    @Override
    public int getCount() {
        return mData.size();
    }

    @Override
    public Object getItem(int position) {
        return mData.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_order,null);
        TextView tv_s1 = (TextView) convertView.findViewById(R.id.tv_s1);
        TextView tv_s2 = (TextView) convertView.findViewById(R.id.tv_s2);
        TextView tv_s3 = (TextView) convertView.findViewById(R.id.tv_s3);
        TextView tv_s4 = (TextView) convertView.findViewById(R.id.tv_s4);
        TextView tv_d1 = (TextView) convertView.findViewById(R.id.tv_d1);
        TextView tv_d2 = (TextView) convertView.findViewById(R.id.tv_d2);
        tv_s1.setText(mData.get(position).get("s1"));
        tv_s2.setText(mData.get(position).get("s2"));
        tv_s3.setText(mData.get(position).get("s3"));
        tv_s4.setText(mData.get(position).get("s4"));
        tv_d1.setText("订单数量："+mData.get(position).get("d1"));
        tv_d2.setText("已交数量："+mData.get(position).get("d2"));
        int d1 = (int)Double.parseDouble(mData.get(position).get("d1"));
        int d2 = (int)Double.parseDouble(mData.get(position).get("d2"));
        int progress = 0;
        if (d2>0){
            progress = d2 / d1 * 100;
            Log.v("info",""+progress);
        }


        ProgressBar bar = (ProgressBar) convertView.findViewById(R.id.progressBar);
        bar.setProgress(progress);

        return convertView;
    }
}
