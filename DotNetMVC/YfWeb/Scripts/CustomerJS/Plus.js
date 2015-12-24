
function getInv(td001_02_03) {
    $('#' + td001_02_03).show();
    $('#' + td001_02_03).html('<img src="/Images/waiting.gif">');
    $.getJSON('/yfs/sale/coptc_all_query?inv=' + td001_02_03,
     function (data) {
         $('#' + td001_02_03).html('');
         $.each(data, function (key, obj) {
             $('#' + td001_02_03).append('<P>仓库名称：' + obj.MC002 + '    数量：' + obj.MC007 + '    包装数量：' + obj.MC014 + '</P>');
         });
     });
}


function getMoc(td001_02_03) {

    $('#' + td001_02_03).show();
    $('#' + td001_02_03).html('<img src="/Images/waiting.gif">');
    $.getJSON('/yfs/sale/coptc_all_query?moc=' + td001_02_03,
     function (data) {
         $('#' + td001_02_03).text('');
         $.each(data, function (key, obj) {
             str = '<table class="table">'
             + '<tr>'
             + '<tb>工单单别：</tb><tb>' + obj.TA001 + '-' + obj.TA002 + '</tb><tb>预计产量：</tb><tb>' + obj.TA015 + '/<tb><tb>已生产量：</tb><tb>' + obj.TA017 + '</tb>'
             + '</tr>'
             + '<tr>'
             + '<tb>报废数量：</tb><tb>' + obj.TA018 + '</tb><tb>破坏数量：</tb><tb>' + obj.TA060 + '/<tb><th>预计开工日：</tb><tb>' + obj.TA019 + '</tb>'
             + '</tr>'
             + '<tr>'
             + '<tb>预计完工日：</tb><tb>' + obj.TA010 + '</tb><tb>实际开工日：</tb><tb>' + obj.TA012 + '/<tb><tb>实际完工日：</tb><tb>' + obj.TA014 + '</tb>'
             + '</tr>'
             + '</table>';
             $('#' + td001_02_03).append(str);
         });
     });
}


function divHide(td001_02_03) {

    $('#' + td001_02_03).html('');
}


function headHide() {
    if ($('#head').text() == '隐藏条件区域') {
        $('#head').text('显示条件区域');
        $('#orderList').hide();
    }
    else {
        $('#head').text('隐藏条件区域');
        $('#orderList').show();
    };
}

function load(td001_02_03) {
    $('#' + td001_02_03).show();
    $('#' + td001_02_03).html('<img src="/Images/waiting.gif">');
}

function dy(td001_02_03, user, type) {
    var $postUrl = "/yfs/dy/Add";

    var $data = { "user": user, "billNo": td001_02_03, "type": type };
    var $type = "json";
    $.post($postUrl, $data, function (data) {
        alert(data);
    }, $type);
}


function dydel(td001_02_03, user, type) {
    var $postUrl = "/yfs/dy/del";
    var $data = { "user": user, "billNo": td001_02_03, "type": type };
    var $type = "json";
    $.post($postUrl, $data, function (data) {
        alert(data);
    }, $type);
}


function showLoading() {
    $("body").append('<div id="info-loading"><div id="center-box"><div class="loading-alert-l"><img src="/Images/waiting.gif"> 数据处理中，请稍后</div></div></div>');
    $("#info-loading").css('height', $(window).height());
}
function hideLoading() {
    $("#info-loading").remove();
}

function OnSuccess(response) {
    alert(response);
}
function OnFailure(response) {
    alert("没找到对应的控制器，路径，方法");
}

function get_inv(id, url, first) {
    if (first == true) {
        $('#' + id).html('<img src="/Images/waiting.gif">');
    };
    $.getJSON('/webservice/day_in_inv?type=' + url,
         function (data) {
             $('#' + id).html('');
             $.each(data, function (key, obj) {
                 $('#' + id).append('<h5>单别：<span class="badge">' + obj.S1 + '</span>    数量：<span class="badge">' + obj.D1 + '</span>    包装数量：<span class="badge">' + obj.D2 + '</span></h5>');
             });
         });
}

function get_in_inv() {
    get_inv('inv_day', 'day', true);
    get_inv('inv_m', 'month', true);
    get_inv('inv_y', 'year', true);
    sale("/webservice/COPTD/", "cop_month");
    sale("/webservice/COPTD/?lastmonth=TRUE", "cop_last_month");
    sale("/webservice/Sale/", "sale");
}

function get_in_inv_time() {
    get_inv('inv_day', 'day', false);
    get_inv('inv_m', 'month', false);
    get_inv('inv_y', 'year', false);
    sale("/webservice/COPTD/", "cop_month");
    sale("/webservice/COPTD?lastmonth=TRUE", "cop_last_month");
    sale("/webservice/Sale/", "sale");
}

function sale(URL, id) {
    require.config({
        paths: {
            "echarts": "/Scripts/echarts/echarts",
            "echarts/chart/map": "/Scripts/echarts/echarts-map"
        }
    });

    require(
        [
            "echarts",
            "echarts/chart/map"
        ],
        function (ec) {
            var myChart = ec.init(document.getElementById(id));
            
            $.getJSON(URL,
                function (data) {
                    myChart.setOption(data);
                });

        }
    );
}


function load_zb(url, eid) {
    $.get(url, function (data) {
        $('#' + eid).html(data);
    });
}

function order_zb(eid, url) {
    $("#" + eid).html('<img src="/Images/waiting.gif">');
    $.getJSON(url,
        function (data) {
            $("#" + eid).html('');
            $("#" + eid).text(data + '天');
        });
}

function loadbyid(eid) {
    $("#" + eid).html('<img src="/Images/waiting.gif">');
}

function hideloadbyid(eid) {
    $("#" + eid).html('');
}

