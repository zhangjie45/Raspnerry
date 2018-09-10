<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/4/26
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>数据展示</title>

    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-switch.js"></script>
    <script type="text/javascript" src="js/echarts.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bootstrap-switch.css"/>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        .main {
            width: 100%;
            height: 100%;
            position: absolute;
        }

        .quarter-div {
            width: 50%;
            height: 50%;
            float: left;
        }

        h3 {
            text-align: center;
        }

        .btn_switch {
            margin: 16px;
            height: 30px;
        }

        p {
            font-size: 20px;
        }

        td {
            padding-top: 20px;
            padding-bottom: 20px;
            font-size: 20px;
        }
    </style>
</head>
<body>
<div>
    <div><img src="img/logo.png"></div>
</div>
<div class="main">
    <div class="quarter-div temperature">
        <h3>电流展示区</h3>
        <div id="temperature" style="width: 500px;height: 280px; margin-left: 80px;">
        </div>
    </div>
    <div class="quarter-div control">
        <div style="text-align: center">

            <div><h3>控制区 </h3></div>

        </div>

        <div id="switch_pump" class="btn_switch" style="text-align:center;">
            <p>水泵<input name="status_switch_pump" type="checkbox">
            </p>
        </div>
        <div id="switch_electrolysis" class="btn_switch" style="text-align:center;">
            <p>电解<input name="status_switch_electrolysis" id="status_switch_electrolysis" type="checkbox"
            >
            </p>
        </div>
        <div id="switch_fan" class="btn_switch" style="text-align:center;">
            <p>风扇<input name="status_switch_fan" type="checkbox">
            </p>
        </div>
    </div>
    <div class="quarter-div voltage">
        <h3>电压展示区</h3>
        <div id="voltage" style="width: 500px;height: 280px; margin-left: 80px;">
        </div>
    </div>
    <div class="quarter-div data" style=" display: table-cell;">
        <h3>相关数据展示区</h3>
        <div>
            <table border="0" style="text-align: center;background-color: #dddddd;width: 100%;margin: 10px">
                <tr>
                    <td>电压(V):</td>
                    <td id="now_voltage" style="text-align: left">12.7</td>
                    <td>材质:</td>
                    <td style="text-align: left">304不锈钢</td>
                </tr>
                <tr>
                    <td>电流(A):</td>
                    <td id="now_current" style="text-align: left">89.5</td>
                    <td>直径(mm):</td>
                    <td style="text-align: left">16</td>
                </tr>
                <tr>
                    <td>温度(℃):</td>
                    <td id="now_temp" style="text-align: left">58.25</td>
                    <td>水位:</td>
                    <td id="now_water_level" style="text-align: left">16</td>
                </tr>
                <tr>
                    <td>已用时间(min):</td>
                    <td id="already" style="text-align: left">14</td>
                    <td>预计剩余时间(min):</td>
                    <td style="text-align: left">3</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    var myCharts = echarts.init(document.getElementById('temperature'));
    myCharts.setOption({
        xAxis: {
            type: 'category',
            data: []
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '电流',
            data: [],
            type: 'line',
            smooth: true
        }]
    });
    myCharts.showLoading();
    setTimeout(function () {
            Push();
        },
        200);
    setInterval(function () {
            Push();
        },
        500);

    function Push() {
        $.ajax({
            type: "get",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "http://192.168.43.19:8001/current_table",    //请求发送到TestServlet处
            data: {},
            timeout: 1000,
            dataType: "json",//返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    var data1 = new Array();
                    var data2 = new Array();
                    if (result.length > 0) {
                        for (var i = 0; i < result.length - 1; i++) {
                            data1[i] = result[i][0];
                            data2[i] = result[i][1];
                        }
                    }
                    myCharts.hideLoading();    //隐藏加载动画
                    myCharts.setOption({        //加载数据图表
                        xAxis: {
                            data: data1
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '电流',
                            data: data2
                        }]
                    });
                }
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                //   alert("图表请求数据失败!");
                myCharts.hideLoading();
            }
        })
    }
</script>
<script type="text/javascript">
    var voltage_myCharts = echarts.init(document.getElementById('voltage'));
    voltage_myCharts.setOption({
        xAxis: {
            type: 'category',
            data: []
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '电流',
            data: [],
            type: 'line',
            smooth: true
        }]
    });
    voltage_myCharts.showLoading();
    setTimeout(function () {
            voltge_Push();
        },
        200);
    setInterval(function () {
            voltge_Push();
        },
        1000);

    function voltge_Push() {
        $.ajax({
            type: "get",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "http://192.168.43.19:8001/temp_table",    //请求发送到TestServlet处
            data: {},
            timeout: 1000,
            dataType: "json",//返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    var data1 = new Array();
                    var data2 = new Array();
                    if (result.length > 0) {
                        for (var i = 0; i < result.length - 1; i++) {
                            data1[i] = result[i][0];
                            data2[i] = result[i][1];
                        }
                    }
                    voltage_myCharts.hideLoading();    //隐藏加载动画
                    voltage_myCharts.setOption({        //加载数据图表
                        xAxis: {
                            data: data1
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '电流',
                            data: data2
                        }]
                    });
                }
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                //   alert("图表请求数据失败!");
                voltage_myCharts.hideLoading();
            }
        })
    }
</script>
<script type="text/javascript">

    $('[name="status_switch_electrolysis"]').bootstrapSwitch({
        onText: "启动",
        offText: "关闭",
        onColor: "success",
        offColor: "info",
        size: "small",
        onSwitchChange: function (event, state) {
            if (state == true) {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k1=off",//开
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            } else {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k1=on",    //关
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            }
        }
    })
    <!--水泵开关-->
    $('[name="status_switch_pump"]').bootstrapSwitch({
        onText: "启动",
        offText: "关闭",
        onColor: "success",
        offColor: "info",
        size: "small",
        onSwitchChange: function (event, state) {
            if (state == true) {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k2=off",//开
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            } else {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k2=on",//关
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            }
        }
    })
    <!--风扇开关-->
    $('[name="status_switch_fan"]').bootstrapSwitch({
        onText: "启动",
        offText: "关闭",
        onColor: "success",
        offColor: "info",
        size: "small",
        onSwitchChange: function (event, state) {
            if (state == true) {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k3=off",
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            } else {
                $.ajax({
                    type: "get",
                    async: true,//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url: "http://192.168.43.19:8001/button?k3=on",
                    data: {},
                    timeout: 0,
                    dataType: "json",//返回数据形式为json
                    success: function (result) {
                    },
                });
            }
        }
    })
</script>
<!--获取当前按钮的状态 -->
<script type="text/javascript">
    setInterval(function () {
        button_status();
    }, 1000);
    window.onload = button_status;

    function button_status() {
        var k1, k2, k3;
        var status_switch_electrolysis = $('[name="status_switch_electrolysis"]').bootstrapSwitch('state');
        var status_switch_pump = $('[name="status_switch_pump"]').bootstrapSwitch('state');
        var status_switch_fan = $('[name="status_switch_fan"]').bootstrapSwitch('state');
        $.ajax({
            type: 'get',
            async: true,
            url: 'http://192.168.43.19:8001/button_status',
            data: {},
            dataType: 'json',
            success: function (data) {
                k1 = data.k1;
                k2 = data.k2;
                k3 = data.k3;
                if (k1 == status_switch_electrolysis) {
                } else {
                    $('[name="status_switch_electrolysis"]').bootstrapSwitch('state', k1);
                }
                if (k2 == status_switch_pump) {
                } else {
                    $('[name="status_switch_pump"]').bootstrapSwitch('state', k2);
                }
                if (k3 == status_switch_fan) {
                } else {
                    $('[name="status_switch_fan"]').bootstrapSwitch('state', k3);
                }
            }
        });
    }
</script>
<!-- 获取实时数据-->
<script type="text/javascript">
    window.onload = data_now;
    var now_current, now_time_used, now_temp, now_volt, now_water_level;
    var voltage = document.getElementById('now_voltage');
    var current = document.getElementById('now_current');
    var temp = document.getElementById('now_temp');
    var time_used = document.getElementById('already');
    var water_level = document.getElementById('now_water_level');
    setInterval(function () {
        data_now();
    }, 1000);

    function data_now() {
        $.ajax({
            type: 'get',
            async: true,
            url: 'http://192.168.43.19:8001/global_status',
            data: {},
            dataType: 'json',
            success: function (data) {
                now_current = data.current;
                now_time_used = data.time_used;
                now_temp = data.temp;
                now_volt = data.volt;
                now_water_level = data.water_level
                //赋值
                voltage.innerText = now_volt;
                current.innerText = now_current;
                temp.innerText = now_temp;
                time_used.innerText = now_time_used;
                water_level.innerText = now_water_level;
            }
        });

    }
</script>
</body>
</html>
