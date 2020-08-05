<%--
  Created by IntelliJ IDEA.
  User: 文宏
  Date: 2020/8/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/static/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form">
            <div class="layui-form-item">
                <label for="storeId" class="layui-form-label">库存编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="storeId" name="storeId" required="" autocomplete="off" class="layui-input" readonly></div>
            <div class="layui-form-item">
                <label for="storeName" class="layui-form-label">
                    <span class="x-red">*</span>商品名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="storeName" name="storeName" required="" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="num" class="layui-form-label">
                    <span class="x-red">*</span>商品库存</label>
                <div class="layui-input-inline">
                    <input type="text" id="num" name="num" required="" autocomplete="off" class="layui-input"></div>
            <div class="layui-form-item">
                <label for="uNum" class="layui-form-label">
                    <span class="x-red">*</span>库存上限</label>
                <div class="layui-input-inline">
                    <input type="password" id="uNum" name="uNum" required="" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="dNum" class="layui-form-label">
                    <span class="x-red">*</span>库存下限</label>
                <div class="layui-input-inline">
                    <input type="text" id="dNum" name="dNum" required="" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="add" lay-submit="">修改</button></div>
        </form>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layer'],
    function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //监听提交
        form.on('submit(add)',
            function(data) {
                console.log(data);
                //发异步，把数据提交给php
                layer.alert("增加成功", {
                        icon: 6
                    },
                    function() {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                return false;
            });

    });
</script>
</html>
