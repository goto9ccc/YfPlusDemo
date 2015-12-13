package com.winzxin.yfhelper.activity;

import android.graphics.Typeface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

import com.winzxin.yfhelper.R;

import java.util.ArrayList;
import java.util.List;

import lecho.lib.hellocharts.listener.PieChartOnValueSelectListener;
import lecho.lib.hellocharts.model.PieChartData;
import lecho.lib.hellocharts.model.SliceValue;
import lecho.lib.hellocharts.util.ChartUtils;
import lecho.lib.hellocharts.view.PieChartView;

public class PieActivity extends AppCompatActivity {

    private PieChartView chart;
    private PieChartData data;

    private boolean hasLabels = false;
    private boolean hasLabelsOutside = true ;
    private boolean hasCenterCircle = false;
    private boolean hasCenterText1 = false;
    private boolean hasCenterText2 = false;
    private boolean isExploded = false;
    private boolean hasLabelForSelected = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pie);
        chart = (PieChartView) findViewById(R.id.chart);
        chart.setOnValueTouchListener(new ValueTouchListener());
        generateData();
    }


    private void generateData() {
        int numValues = 6;
        List<SliceValue> values = new ArrayList<SliceValue>();
        for (int i = 0; i < numValues; ++i) {
            SliceValue sliceValue = new SliceValue((float) Math.random() * 30 + 15, ChartUtils.pickColor());
            values.add(sliceValue);
        }
        data = new PieChartData(values);
        data.setHasLabels(hasLabels);
        data.setHasLabelsOnlyForSelected(hasLabelForSelected);
        data.setHasLabelsOutside(hasLabelsOutside);
        data.setHasCenterCircle(hasCenterCircle);
        if (isExploded) {
            data.setSlicesSpacing(24);
        }

        if (hasCenterText1) {
            data.setCenterText1("Hello!");
            Typeface tf = Typeface.createFromAsset(PieActivity.this.getAssets(), "Roboto-Italic.ttf");
            data.setCenterText1Typeface(tf);
            data.setCenterText1FontSize(ChartUtils.px2sp(getResources().getDisplayMetrics().scaledDensity,
                    (int) getResources().getDimension(R.dimen.pie_chart_text1_size)));
        }

        if (hasCenterText2) {
            data.setCenterText2("Charts (Roboto Italic)");

            Typeface tf = Typeface.createFromAsset(PieActivity.this.getAssets(), "Roboto-Italic.ttf");

            data.setCenterText2Typeface(tf);
            data.setCenterText2FontSize(ChartUtils.px2sp(getResources().getDisplayMetrics().scaledDensity,
                    (int) getResources().getDimension(R.dimen.pie_chart_text2_size)));
        }

        chart.setPieChartData(data);
    }


    private class ValueTouchListener implements PieChartOnValueSelectListener {

        @Override
        public void onValueSelected(int arcIndex, SliceValue value) {
            Toast.makeText(PieActivity.this, "选中: " + value, Toast.LENGTH_SHORT).show();
        }

        @Override
        public void onValueDeselected() {
            // TODO Auto-generated method stub

        }

    }

}
