<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/5/23
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/bootstrap-switch.js"></script>
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrap-switch.css"/>
<head>
    <title>Title</title>
    <style type="text/css">
        .switch {

            margin: 16px;
            height: 30px;

        }
    </style>
</head>
<body>
<div id="switch_pump" class="switch">
    <p>水泵<input name="status_switch_pump" type="checkbox" data-size="small">
    </p>
</div>
<script type="text/javascript">
    <!--获取水泵开关的状态 -->
    $('[name="status_switch_pump"]').bootstrapSwitch({
        onText: "启动",
        offText: "停止",
        onColor: "success",
        offColor: "info",
        size: "small",
        onSwitchChange: function (event, state) {
            if (state == true) {
                console.log($('[name="status_switch_pump"]').bootstrapSwitch('state'));

            } else {
                console.log($('[name="status_switch_pump"]').bootstrapSwitch('state'));
            }
        }
    })
</script>
</body>
</html>
