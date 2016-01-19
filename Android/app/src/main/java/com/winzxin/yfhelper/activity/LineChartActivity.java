package com.winzxin.yfhelper.activity;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.winzxin.yfhelper.common.Config;
import com.winzxin.yfhelper.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import lecho.lib.hellocharts.listener.LineChartOnValueSelectListener;
import lecho.lib.hellocharts.model.Axis;
import lecho.lib.hellocharts.model.AxisValue;
import lecho.lib.hellocharts.model.Line;
import lecho.lib.hellocharts.model.LineChartData;
import lecho.lib.hellocharts.model.PointValue;
import lecho.lib.hellocharts.model.ValueShape;
import lecho.lib.hellocharts.util.ChartUtils;
import lecho.lib.hellocharts.view.LineChartView;

public class LineChartActivity extends AppCompatActivity {
    private LineChartView chart;
    private LineChartData data;
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
        chart = (LineChartView) findViewById(R.id.chart);
        generateData();
    }


    private void generateData() {
        final List<Line> lines = new ArrayList<>();
        final List<PointValue> values = new ArrayList<>();
        final List<AxisValue> axisValues = new ArrayList<>();
        Config config = Config.getInstance(this);
        RequestQueue rq = Volley.newRequestQueue(this);
        StringRequest sq = new StringRequest(config.getmServerUrl()
                + "/androidchart/saleline", new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                try {
                    JSONObject jsonObject = new JSONObject(s);
                    JSONArray jsonArray = jsonObject.getJSONArray("data");
                    for (int i = 0; i < jsonArray.length(); i++) {

                        JSONObject data = jsonArray.getJSONObject(i);
                        values.add(new PointValue(i, ((float) data.getDouble("D1"))));
                        axisValues.add(new AxisValue((float) data.getDouble("D1"))
                                .setLabel(data.getString("S1")));
                    }

                    Line line = new Line(values);
                    line.setColor(ChartUtils.COLORS[0]).setShape(shape).setCubic(isCubic)
                            .setFilled(isFilled).setHasLabels(hasLabels)
                            .setHasLabelsOnlyForSelected(hasLabelForSelected)
                            .setHasLines(hasLines).setHasPoints(hasPoints);

                    lines.add(line);
                    data = new LineChartData(lines);
                    Axis axisX = new Axis();
                    axisX.setHasTiltedLabels(true);
                    axisX.setTextColor(Color.BLUE);
                    axisX.setName("日期");
                    //axisX.setMaxLabelChars(10);
                    axisX.setValues(axisValues);
                    data.setAxisXBottom(axisX);
                    Axis axisY = new Axis().setHasLines(true);
                    axisY.setName("金额");
                    data.setAxisYLeft(axisY);
                    data.setBaseValue(Float.NEGATIVE_INFINITY);
                    chart.setLineChartData(data);
                    chart.setOnValueTouchListener(new ValueTouchListener());
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


    private class ValueTouchListener implements LineChartOnValueSelectListener {

        @Override
        public void onValueSelected(int lineIndex, int pointIndex, PointValue value) {
            Toast.makeText(LineChartActivity.this, "选中: "
                    + value, Toast.LENGTH_SHORT).show();
        }

        @Override
        public void onValueDeselected() {


        }

    }
}
