package com.winzxin.yfhelper.activity;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.handmark.pulltorefresh.library.PullToRefreshBase;
import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.winzxin.yfhelper.common.YfKnow;
import com.winzxin.yfhelper.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ContactsActivity extends AppCompatActivity implements PullToRefreshBase
        .OnRefreshListener2<ListView>,AdapterView.OnItemClickListener{


    private PullToRefreshListView mPullRefreshListView;
    private String urlStr = "http://192.168.1.115:81/service/cmsmv";

    private int page = 1;
    private SimpleAdapter mAdapter= null;
    private ArrayList<Map<String,String>> mDatas = new ArrayList<>();
    private int[] mItemIds = {R.id.tv_name,R.id.tv_tel,R.id.tv_dept};
    private String[] mItemContext = {"name","tel","dept"};
    private String key = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contacts);
        mPullRefreshListView = (PullToRefreshListView) findViewById(R.id
                .pull_refresh_contacts);
        if (savedInstanceState !=null){
            if (YfKnow.mData != null){
                mDatas = YfKnow.mData;
                YfKnow.mData = null;
            }
            page = savedInstanceState.getInt("page");
        }
        mPullRefreshListView.setMode(PullToRefreshBase.Mode.BOTH);
        View view = getLayoutInflater().inflate(R.layout.view_empty,null);
        TextView tv = (TextView) view.findViewById(R.id.textView_info);
        tv.setText("正在加载数据\n……");
        mPullRefreshListView.setEmptyView(view);
        mPullRefreshListView.setOnRefreshListener(this);
        ListView actualListView = mPullRefreshListView.getRefreshableView();
        mAdapter = new SimpleAdapter(this,mDatas,R.layout.item_contacts,mItemContext,
                mItemIds);
        actualListView.setAdapter(mAdapter);
        actualListView.setOnItemClickListener(this);
        fillData();
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        String tel = mDatas.get(position-1).get("tel");
        if (TextUtils.isEmpty(tel)){
            return;
        }

        Intent intent = new Intent(Intent.ACTION_CALL,Uri.parse("tel:"+tel));
        startActivity(intent);
    }

    @Override
    public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
        page = 1;
        fillData();
    }

    @Override
    public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
        fillData();
    }

    private void fillData() {
        RequestQueue rq = Volley.newRequestQueue(getApplication());
        String url = urlStr;
        StringRequest sq = new StringRequest(url, new Response
                .Listener<String>() {
            @Override
            public void onResponse(String s) {
                try {
                    if (page == 1){
                        mDatas.clear();
                    }
                    page++;

                    JSONArray jsonArray = new JSONArray(s);
                    for (int i = 0; i < jsonArray.length() ; i++) {
                        JSONObject know = jsonArray.getJSONObject(i);
                        Map<String,String> map = new HashMap<>();
                        map.put("name",know.getString("S1"));
                        map.put("tel", know.getString("S2"));
                        map.put("dept", know.getString("S4"));
                        mDatas.add(map);
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    mAdapter.notifyDataSetChanged();
                    mPullRefreshListView.onRefreshComplete();
                }
            }


        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Toast.makeText(getParent(), "数据获取异常", Toast.LENGTH_SHORT).show();

            }
        });
        rq.add(sq);
    }
}
