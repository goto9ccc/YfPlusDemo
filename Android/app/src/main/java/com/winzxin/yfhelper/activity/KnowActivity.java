package com.winzxin.yfhelper.activity;

import android.app.Dialog;
import android.support.v4.view.MenuItemCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.SearchView;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
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

public class KnowActivity extends AppCompatActivity implements PullToRefreshBase
        .OnRefreshListener2<ListView>,AdapterView.OnItemClickListener {


    private PullToRefreshListView mPullRefreshListView;
    private String urlStr = "http://erpask.sinaapp.com/server.php"
            +"?pageIndex=";
    private String mQuestionUrl = "http://erpask.sinaapp.com/question.php?id=";
    private int page = 1;
    private SimpleAdapter mAdapter= null;
    private ArrayList<Map<String,String>> mDatas = new ArrayList<>();
    private int[] mItemIds = {R.id.tv_title};
    private String[] mItemContext = {"title"};
    private String key = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_know);

        mPullRefreshListView = (PullToRefreshListView) findViewById(R.id
                .pull_refresh_list);
        if (savedInstanceState !=null){
            if (YfKnow.mData != null){
                mDatas = YfKnow.mData;
                YfKnow.mData = null;
            }
            page = savedInstanceState.getInt("page");
        }
        mPullRefreshListView.setMode(PullToRefreshBase.Mode.BOTH);
        View view = getLayoutInflater().inflate(R.layout.view_empty, null);
        mPullRefreshListView.setEmptyView(view);
        mPullRefreshListView.setOnRefreshListener(this);
        ListView actualListView = mPullRefreshListView.getRefreshableView();
        mAdapter = new SimpleAdapter(this,mDatas,R.layout.item_know,mItemContext,
                mItemIds);

        actualListView.setAdapter(mAdapter);
        actualListView.setOnItemClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        RequestQueue rq = Volley.newRequestQueue(getApplication());
        StringRequest sq = new StringRequest(mQuestionUrl + mDatas.get(position-1)
                .get("id"), new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                try {
                    JSONArray jsonArray = new JSONArray(s);
                    JSONObject jsonObject = jsonArray.getJSONObject(0);
                    Dialog dialog = new Dialog(KnowActivity.this);
                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
                    dialog.setContentView(R.layout.view_card);
                    //dialog.getWindow().setBackgroundDrawable(null);

                    // dialog.setTitle("内容");
                    TextView tv = (TextView) dialog.findViewById(R.id.tv_context);
                    tv.setText(jsonObject.getString("KBMemo"));
                    TextView tvTitle = (TextView) dialog.findViewById(R.id.tv_title);
                    tvTitle.setText(jsonObject.getString("KBTitle"));
                    dialog.show();
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
        String url = urlStr+page;
        if (TextUtils.isEmpty(key) == false){
            url = url + "&key="+key;
        }
        StringRequest sq = new StringRequest(url, new Response
                .Listener<String>() {
            @Override
            public void onResponse(String s) {
                try {
                    if (page == 1){
                        mDatas.clear();
                    }
                    page++;
                    JSONObject jsonObject = new JSONObject(s);
                    JSONArray jsonArray = jsonObject.getJSONArray("data");
                    for (int i = 0; i < jsonArray.length() ; i++) {
                        JSONObject know = jsonArray.getJSONObject(i);
                        Map<String,String> map = new HashMap<>();
                        map.put("id",know.getString("id"));
                        map.put("title", know.getString("KBTitle"));
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

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        YfKnow.mData = mDatas;
        outState.putInt("page",page);
        super.onSaveInstanceState(outState);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu, menu);
        MenuItem menuItem = menu.findItem(R.id.action_query);
        final SearchView searchView = (SearchView) MenuItemCompat.getActionView(menuItem);
        searchView.setQueryHint("查询关键字，如工单");
        searchView.setIconifiedByDefault(true);
        searchView.setSubmitButtonEnabled(true);
        searchView.setQuery(key, false);
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                key =  searchView.getQuery().toString();
                page = 1;
                fillData();
                return true;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                return true;
            }
        });
        MenuItemCompat.setOnActionExpandListener(menuItem, new MenuItemCompat.OnActionExpandListener() {


            @Override
            public boolean onMenuItemActionExpand(MenuItem item) {
                return true;
            }

            @Override
            public boolean onMenuItemActionCollapse(MenuItem item) {
                key = searchView.getQuery().toString();
                page = 1;
                fillData();
                return true;
            }
        });

        return super.onCreateOptionsMenu(menu);
    }

}
