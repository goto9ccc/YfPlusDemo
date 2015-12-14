package com.winzxin.yfhelper.fragment;


import android.app.Dialog;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.handmark.pulltorefresh.library.PullToRefreshBase;
import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.winzxin.yfhelper.Common.Config;
import com.winzxin.yfhelper.R;
import com.winzxin.yfhelper.adapter.OrderAdapter;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;


public class TwoFragment extends Fragment {

    private PullToRefreshListView mPullRefreshListView;
    private OrderAdapter adapter;
    private ArrayList<HashMap<String, String>> mData = new ArrayList<>();
    private String td001String,td005String,td006String;
    private int page = 1;
    private String QueryString = "";
    private String baseUrl = "";
    public TwoFragment() {

    }


    @Override
    public View onCreateView(final LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_two, container, false);
        mPullRefreshListView = (PullToRefreshListView) view.findViewById(R.id.order_list);
        mPullRefreshListView.setMode(PullToRefreshBase.Mode.BOTH);
        baseUrl = Config.getInstance(getActivity()).getmServerUrl() + "/service/order";
        mPullRefreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener2<ListView>() {
            @Override
            public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
                mData.clear();
                page =1;
                getData(baseUrl + "?p=" + page +QueryString);
            }

            @Override
            public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
                page += 1;
                getData(baseUrl + "?p=" + page +QueryString);
            }

        });

        ListView mListView = mPullRefreshListView.getRefreshableView();
        mListView.addHeaderView(inflater.inflate(R.layout.item_header_order, null));
        adapter = new OrderAdapter(mData);
        mListView.setAdapter(adapter);
        ImageButton button = (ImageButton) view.findViewById(R.id.button_order_filter);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final Dialog dialog = new Dialog(getActivity());
                dialog.setTitle("设置查询条件");
                dialog.setContentView(R.layout.dialog_order_search);
                ((EditText) dialog.findViewById(R.id.edt_td001)).setText(td001String);
                ((EditText) dialog.findViewById(R.id.edt_td005)).setText(td005String);
                ((EditText) dialog.findViewById(R.id.edt_td006)).setText(td006String);
                Button searchButton = (Button) dialog.findViewById(R.id.button_ok);
                searchButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        td001String = ((EditText) dialog.findViewById(R.id.edt_td001)).getText().toString();
                        td005String = ((EditText) dialog.findViewById(R.id.edt_td005)).getText().toString();
                        td006String = ((EditText) dialog.findViewById(R.id.edt_td006)).getText().toString();
                        page =1;
                        mData.clear();
                        QueryString = "";

                        if (!TextUtils.isEmpty(td001String)){
                            QueryString = QueryString + "&td001=" + td001String;
                        }
                        if (!TextUtils.isEmpty(td005String)){
                            QueryString = QueryString + "&td005=" + td005String;
                        }
                        if (!TextUtils.isEmpty(td006String)){
                            QueryString = QueryString + "&td006=" + td006String;
                        }


                        getData(baseUrl + "?p=" + page +QueryString);
                        dialog.dismiss();
                    }
                });
                dialog.show();
            }
        });



        return view;
    }

    private void getData(String url){
        RequestQueue requestQueue = Volley.newRequestQueue(getActivity().getApplication());
        StringRequest stringRequest = new StringRequest(url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        try {
                            JSONArray jsonArray = new JSONArray(s);
                            for (int i = 0; i <jsonArray.length() ; i++) {
                                JSONObject order  = jsonArray.getJSONObject(i);
                                //添加数据
                                HashMap<String,String> map = new HashMap<>();
                                map.put("s1", "订单：" + order.getString("S1"));
                                map.put("s2", "品号：" + order.getString("S2"));
                                map.put("s3", "品名：" + order.getString("S3"));
                                map.put("s4", "规格：" + order.getString("S4"));
                                map.put("d1", "" + order.getDouble("D1"));
                                map.put("d2", "" + order.getDouble("D2"));
                                mData.add(map);
                            }
                        } catch (JSONException e) {
                            Toast.makeText(getActivity(), "数据解析失败", Toast.LENGTH_LONG).show();
                            e.printStackTrace();
                        } finally {
                            adapter.notifyDataSetChanged();
                            mPullRefreshListView.onRefreshComplete();
                        }

                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                mPullRefreshListView.onRefreshComplete();
                Toast.makeText(getActivity(),"网络连接失败或URL地址不对\n"+ baseUrl + "?p=" + page + QueryString,Toast.LENGTH_LONG).show();
            }
        });
        requestQueue.add(stringRequest);
    }


}
