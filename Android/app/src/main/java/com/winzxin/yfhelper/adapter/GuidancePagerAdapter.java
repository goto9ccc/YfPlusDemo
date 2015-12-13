package com.winzxin.yfhelper.adapter;

import android.support.v4.view.PagerAdapter;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.winzxin.yfhelper.R;

import java.util.ArrayList;
import java.util.List;

/**
 * 这是  songgo 在 2015/10/18 创建的
 */
public class GuidancePagerAdapter extends PagerAdapter {
    private List<ImageView> imageViews = new ArrayList<>();
    private int[] imageRes = {R.drawable.g1,R.drawable.g2};

    @Override
    public int getCount() {
        return imageRes.length;
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView(imageViews.get(position));
    }
    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        ImageView imageView = new ImageView(container.getContext());
        imageView.setImageResource(imageRes[position]);
        imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
        container.addView(imageView);
        imageViews.add(imageView);
        return imageView;
    }

}
