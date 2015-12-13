package com.winzxin.yfhelper.fragment;


import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.Button;

import com.winzxin.yfhelper.R;
import com.winzxin.yfhelper.activity.ContactsActivity;
import com.winzxin.yfhelper.activity.KnowActivity;
import com.winzxin.yfhelper.barcode.BarScanActivity;


public class fourFragment extends Fragment {

    private Button knowButton;
    private Button contactsButton;
    public fourFragment() {

    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_four, container, false);
        knowButton = (Button) view.findViewById(R.id.button_know);
        knowButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), KnowActivity.class));
            }
        });

        contactsButton = (Button) view.findViewById(R.id.button_employer);
        contactsButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), ContactsActivity.class));
            }
        });
        view.findViewById(R.id.button_bar).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), BarScanActivity.class));
            }
        });
        view.findViewById(R.id.button_gps).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                postLocation();
            }
        });


        return view;
    }

    private void postLocation() {
    }


}
