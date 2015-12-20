package com.winzxin.yfhelper.activity;

import android.graphics.Typeface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.winzxin.yfhelper.Common.Config;
import com.winzxin.yfhelper.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

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

        final List<SliceValue> values = new ArrayList<>();

        Config config = Config.getInstance(this);
        RequestQueue rq = Volley.newRequestQueue(this);
        StringRequest sq = new StringRequest(config.getmServerUrl()
                + "/androidchart/salerPie", new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                JSONObject jsonObject;
                try {
                    jsonObject = new JSONObject(s);
                    JSONArray jsonArray = jsonObject.getJSONArray("data");
                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject data = jsonArray.getJSONObject(i);
                        SliceValue sliceValue = new SliceValue((float)data.getDouble("D1"),
                                ChartUtils.nextColor());
                        values.add(sliceValue);
                    }
                    data = new PieChartData(values);
                    data.setHasLabels(hasLabels);
                    data.setHasLabelsOnlyForSelected(hasLabelForSelected);
                    data.setHasLabelsOutside(hasLabelsOutside);
                    data.setHasCenterCircle(hasCenterCircle);
                    chart.setPieChartData(data);
                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {

            }
        });
        rq.add(sq);

    }


    private class ValueTouchListener implements PieChartOnValueSelectListener {

        @Override
        public void onValueSelected(int arcIndex, SliceValue value) {
            Toast.makeText(PieActivity.this, "选中: " + value, Toast.LENGTH_SHORT).show();
        }

        @Override
        public void onValueDeselected() {

        }

    }

}
