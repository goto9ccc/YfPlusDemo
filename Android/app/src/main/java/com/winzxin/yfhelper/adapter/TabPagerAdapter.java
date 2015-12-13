package com.winzxin.yfhelper.adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.winzxin.yfhelper.fragment.OneFragment;
import com.winzxin.yfhelper.fragment.ThreeFragment;
import com.winzxin.yfhelper.fragment.TwoFragment;
import com.winzxin.yfhelper.fragment.fourFragment;

/**
 * Created by song on 2015/11/22.
 */
public class TabPagerAdapter extends FragmentPagerAdapter {

    String[] mTitles = {"库存","订单","图表","知识库"};
    public TabPagerAdapter(FragmentManager fm) {
        super(fm);
    }
    @Override
    public Fragment getItem(int position) {
        switch (position) {
            case 0:
                return new OneFragment();
            case 1:
                return new TwoFragment();
            case 2:
                return new ThreeFragment();
            case 3:
                return new fourFragment();
        }
        return new OneFragment();
    }

    @Override
    public int getCount() {
        return mTitles.length;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return mTitles[position];
    }

}
