package com.winzxin.yfhelper.fragment;


import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
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
import android.widget.SimpleAdapter;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.handmark.pulltorefresh.library.PullToRefreshBase;
import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.winzxin.yfhelper.common.Config;
import com.winzxin.yfhelper.R;
import com.winzxin.yfhelper.barcode.BarScanActivity;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**

 */
public class FirstFragment extends Fragment {

    private PullToRefreshListView mPullRefreshListView;
    private ImageButton button_search;
    private EditText editText;
    private SimpleAdapter simpleAdapter;
    private List<HashMap<String, String>> mData = new ArrayList<>();
    private ImageButton imageButton;

    private String[] strFrom = new String[]{"MC001", "MC002", "MB002", "MB003",
            "MC007","MC014"};
    private int[] intTo = new int[]{R.id.tv_mc0001, R.id.tv_mc002, R.id.tv_mb002, R.id.tv_mb003, R.id
            .tv_mc007,R.id.tv_mc014};
    private int page = 1;
    private String QueryString = "";
    private String baseUrl = "";
    private String mc001String,mc002String,mb002String,mb003String;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_first, container, false);
        baseUrl = Config.getInstance(getActivity()).getServerUrl() + "/service";
        mPullRefreshListView = (PullToRefreshListView) view.findViewById(R.id.pull_refresh_list);
        mPullRefreshListView.setMode(PullToRefreshBase.Mode.BOTH);
        mPullRefreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener2<ListView>() {
            @Override
            public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
                page = 1;
                mData.clear();
                String url = baseUrl + "?" + QueryString + "&p=" + page;
                getData(url);
            }

            @Override
            public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
                page += 1;
                String url = baseUrl + "?" + QueryString + "&p=" + page;
                getData(url);
            }

        });

        ListView mListView = mPullRefreshListView.getRefreshableView();
        mListView.addHeaderView(inflater.inflate(R.layout.item_header_view, null));
        simpleAdapter = new SimpleAdapter(getActivity(),
                mData, R.layout.item_invmc, strFrom, intTo);
        mListView.setAdapter(simpleAdapter);
        imageButton = (ImageButton) view.findViewById(R.id.button_qr);
        imageButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivityForResult(new Intent(getActivity(), BarScanActivity.class), 1);
            }
        });

        button_search = (ImageButton) view.findViewById(R.id.button_search);
        button_search.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                page =1;
                mData.clear();

                QueryString = "&MC001=" + editText.getText().toString();
                String url = baseUrl + "?" + QueryString + "&p=" + page;
                getData(url);
            }
        });
        editText = (EditText) view.findViewById(R.id.editText);

        ImageButton button = (ImageButton) view.findViewById(R.id.button_invmc_filter);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final Dialog dialog = new Dialog(getActivity());
                dialog.setTitle("设置查询条件");
                dialog.setContentView(R.layout.dialog_invmc_search);
                Button searchButton = (Button) dialog.findViewById(R.id.button_ok);
                ((EditText) dialog.findViewById(R.id.edt_mc001)).setText(mc001String);
                ((EditText) dialog.findViewById(R.id.edt_mc002)).setText(mc002String);
                ((EditText) dialog.findViewById(R.id.edt_mb002)).setText(mb002String);
                ((EditText) dialog.findViewById(R.id.edt_mb003)).setText(mb003String);

                searchButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        mc001String = ((EditText) dialog.findViewById(R.id.edt_mc001)).getText().toString();
                        mc002String = ((EditText) dialog.findViewById(R.id.edt_mc002)).getText().toString();
                        mb002String = ((EditText) dialog.findViewById(R.id.edt_mb002)).getText().toString();
                        mb003String = ((EditText) dialog.findViewById(R.id.edt_mb003)).getText().toString();
                        mData.clear();
                        page = 1;
                        QueryString = "test=test";
                        if (!TextUtils.isEmpty(mc001String)){
                            QueryString = QueryString + "&mc001=" + mc001String;
                        }
                        if (!TextUtils.isEmpty(mc002String)){
                            QueryString = QueryString + "&mc002=" + mc002String;
                        }
                        if (!TextUtils.isEmpty(mb002String)){
                            QueryString = QueryString + "&mb002=" + mb002String;
                        }
                        if (!TextUtils.isEmpty(mb003String)){
                            QueryString = QueryString + "&mb003=" + mb003String;
                        }
                        String url = baseUrl + "?" + QueryString + "&p=" + page;
                        getData(url);
                        dialog.dismiss();
                    }
                });
                dialog.show();
            }
        });

        return view;
    }

    /**
     * 处理扫描返回结果
     * @param requestCode
     * @param resultCode
     * @param data
     */

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK){
            editText.setText(data.getStringExtra("barcode"));
            button_search.callOnClick();
        }
    }

    /**
     * 异步请求 处理数据
     * @param url
     */

    private void getData(String url){
        url = url + QueryString;
        RequestQueue requestQueue = Volley.newRequestQueue(getActivity().getApplication());
        StringRequest stringRequest = new StringRequest(url,
                new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                try {
                    JSONArray jsonArray = new JSONArray(s);
                    for (int i = 0; i <jsonArray.length() ; i++) {
                        JSONObject invmc = jsonArray.getJSONObject(i);
                        //添加数据
                        HashMap<String,String> map = new HashMap<>();
                        map.put("MC001","品号："+invmc.getString("MC001"));
                        map.put("MC002","仓库："+invmc.getString("MC002"));
                        map.put("MB002","品名："+invmc.getString("MB002"));
                        map.put("MB003","规格："+invmc.getString("MB003"));
                        map.put("MC007","数量："+invmc.getDouble("MC007"));
                        map.put("MC014","包装数量："+invmc.getDouble("MC014"));
                        mData.add(map);

                    }
                } catch (JSONException e) {
                    Toast.makeText(getActivity(),"数据解析失败",Toast.LENGTH_LONG).show();
                    e.printStackTrace();
                } finally {
                    simpleAdapter.notifyDataSetChanged();
                    mPullRefreshListView.onRefreshComplete();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Toast.makeText(getActivity(),"网络连接失败",Toast.LENGTH_LONG).show();
                mPullRefreshListView.onRefreshComplete();
            }
        });
        requestQueue.add(stringRequest);
    }


}
