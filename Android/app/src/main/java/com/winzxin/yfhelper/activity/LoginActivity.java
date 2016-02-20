package com.winzxin.yfhelper.activity;

import android.app.Application;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.winzxin.yfhelper.common.Config;
import com.winzxin.yfhelper.R;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class LoginActivity extends AppCompatActivity implements View.OnClickListener {

    private Button mLoginButton;
    private Button mSetButton;
    private EditText mUserEditText;
    private EditText mPasswordEditText;
    private ProgressDialog  mProgressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        mLoginButton = (Button) findViewById(R.id.button_login);
        mSetButton = (Button) findViewById(R.id.button_setting);
        mLoginButton.setOnClickListener(this);
        mSetButton.setOnClickListener(this);
        mUserEditText = (EditText) findViewById(R.id.editText_user);
        mPasswordEditText = (EditText) findViewById(R.id.editText_Password);
        SharedPreferences sharedPreferences = getSharedPreferences("config",Application.MODE_PRIVATE);
        mUserEditText.setText(sharedPreferences.getString("username",""));
        mPasswordEditText.setText(sharedPreferences.getString("password",""));

    }


    @Override
    public void onClick(View v) {
        mProgressDialog = new ProgressDialog(this);

        mProgressDialog.setMessage("正在登录");
        mProgressDialog.show();

        final Config config = Config.getInstance(LoginActivity.this);
        switch (v.getId()){
            case R.id.button_login:
                String URL = config.getServerUrl()+"/Home/Login";
                RequestQueue requestQueue = Volley.newRequestQueue(getApplication());
                StringRequest stringRequest = new StringRequest(StringRequest.Method.POST,
                        URL, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        try {
                            JSONObject jsonObject = new JSONObject(s);
                            if (jsonObject.getBoolean("status")){
                                SharedPreferences sharedPreferences = getSharedPreferences("config", Application.MODE_PRIVATE);
                                SharedPreferences.Editor editor = sharedPreferences.edit();
                                editor.putString("username",mUserEditText.getText().toString());
                                editor.putString("password",mPasswordEditText.getText().toString());
                                editor.commit();
                                startActivity(new Intent(LoginActivity.this, TabMainActivity.class));

                                finish();;
                            }else{
                                Toast.makeText(LoginActivity.this,jsonObject.getString("info"),Toast.LENGTH_LONG).show();
                            }

                        } catch (JSONException e) {
                            e.printStackTrace();

                        } finally {
                            mProgressDialog.dismiss();
                        }
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError volleyError) {
                        mProgressDialog.dismiss();
                        Toast.makeText(LoginActivity.this,"访问错误，检查服务器地址或网络",Toast.LENGTH_LONG).show();
                    }
                }){
                    @Override
                    protected Map<String, String> getParams() throws AuthFailureError {
                        Map<String,String> params = new HashMap<>();
                        params.put("username",mUserEditText.getText().toString());
                        params.put("password",mPasswordEditText.getText().toString());
                        return params;
                    }
                };
                requestQueue.add(stringRequest);
                break;
            case R.id.button_setting:
                final Dialog dialog = new Dialog(this);
                dialog.setTitle("设置服务器地址");
                dialog.setContentView(R.layout.dialog_setting);
                final EditText editText = (EditText) dialog.findViewById(R.id.editText_address);
                editText.setText(config.getServerUrl());
                dialog.findViewById(R.id.button_set_address).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        config.setServerUrl(editText.getText().toString());
                        dialog.dismiss();
                    }
                });
                dialog.show();
                break;
        }
    }
}
