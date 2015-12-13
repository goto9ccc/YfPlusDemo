package com.winzxin.yfhelper.activity;

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

import lecho.lib.hellocharts.listener.LineChartOnValueSelectListener;
import lecho.lib.hellocharts.model.Axis;
import lecho.lib.hellocharts.model.Line;
import lecho.lib.hellocharts.model.LineChartData;
import lecho.lib.hellocharts.model.PointValue;
import lecho.lib.hellocharts.model.ValueShape;
import lecho.lib.hellocharts.util.ChartUtils;
import lecho.lib.hellocharts.view.LineChartView;

public class LineChartActivity extends AppCompatActivity {
    private LineChartView chart;
    private LineChartData data;
    private int numberOfLines = 1;//线条数
    private int maxNumberOfLines = 4;
    private int numberOfPoints = 30;

    float[][] randomNumbersTab = new float[maxNumberOfLines][numberOfPoints];

    private boolean hasAxes = true;
    private boolean hasAxesNames = true;
    private boolean hasLines = true;
    private boolean hasPoints = true;
    private ValueShape shape = ValueShape.CIRCLE;
    private boolean isFilled = false;
    private boolean hasLabels = false;
    private boolean isCubic = false;
    private boolean hasLabelForSelected = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_line_chart);

        chart = (LineChartView)findViewById(R.id.chart);
        generateValues();
        generateData();
        resetViewport();
        chart.setOnValueTouchListener(new ValueTouchListener());
        chart.setViewportCalculationEnabled(false);
    }


    private void generateValues() {
        for (int i = 0; i < maxNumberOfLines; ++i) {
            for (int j = 0; j < numberOfPoints; ++j) {
                randomNumbersTab[i][j] = (float) Math.random() * 100f;
            }
        }
    }

    private void resetViewport() {

//        final Viewport v = new Viewport(chart.getMaximumViewport());
//        v.bottom = 0;
//        v.top = 100;
//        v.left = 0;
//        v.right = numberOfPoints - 1;
//        chart.setMaximumViewport(v);
//        chart.setCurrentViewport(v);
    }

    private void generateData() {

        final List<Line> lines = new ArrayList<>();
        for (int i = 0; i < numberOfLines; ++i) {
            final List<PointValue> values = new ArrayList<>();
            Config config = Config.getInstance(this);
            RequestQueue rq = Volley.newRequestQueue(this);
            StringRequest sq = new StringRequest(config.getmServerUrl() + "/androidchart/saleline", new Response.Listener<String>() {
                @Override
                public void onResponse(String s) {
                    try {
                        JSONObject jsonObject = new JSONObject(s);
                        JSONArray jsonArray = jsonObject.getJSONArray("data");
                        for (int i = 0; i <jsonArray.length() ; i++) {
                            JSONObject data = jsonArray.getJSONObject(i);
                            values.add(new PointValue(i, ((float) data.getDouble("D1"))));
                        }

                        Line line = new Line(values);
                        line.setColor(ChartUtils.COLORS[0]).setShape(shape).setCubic(isCubic)
                                .setFilled(isFilled).setHasLabels(hasLabels)
                                .setHasLabelsOnlyForSelected(hasLabelForSelected)
                                .setHasLines(hasLines).setHasPoints(hasPoints);

                        lines.add(line);
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
        data = new LineChartData(lines);
        if (hasAxes) {
            Axis axisX = new Axis();
            Axis axisY = new Axis().setHasLines(true);
            if (hasAxesNames) {
                axisX.setName("Axis X");
                axisY.setName("Axis Y");
            }
            data.setAxisXBottom(axisX);
            data.setAxisYLeft(axisY);
        } else {
            data.setAxisXBottom(null);
            data.setAxisYLeft(null);
        }

        data.setBaseValue(Float.NEGATIVE_INFINITY);
        chart.setLineChartData(data);

    }


    private class ValueTouchListener implements LineChartOnValueSelectListener {

        @Override
        public void onValueSelected(int lineIndex, int pointIndex, PointValue value) {
            Toast.makeText(LineChartActivity.this, "选中: " + value, Toast.LENGTH_SHORT).show();
        }

        @Override
        public void onValueDeselected() {


        }

    }
}
