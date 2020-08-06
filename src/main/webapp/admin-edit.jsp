<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.2</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
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
            <input id="empId" name="empId" type="hidden">
            <div class="layui-form-item">
                <label for="username" class="layui-form-label">
                    <span class="x-red">*</span>用户名
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="username" name="username" required="" lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>将会成为您唯一的用户名
                </div>
            </div>
            <div class="layui-form-item">
                <label for="empName" class="layui-form-label">
                    <span class="x-red">*</span>员工姓名
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="empName" name="empName" required="" lay-verify="empName"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="sex" class="layui-form-label">
                    <span class="x-red">*</span>性别
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="sex" name="sex" required="" lay-verify="sex"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="tel" class="layui-form-label">
                    <span class="x-red">*</span>手机
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="tel" name="tel" required="" lay-verify="phone"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>将会成为您唯一的登入名
                </div>
            </div>
            <div class="layui-form-item">
                <label for="email" class="layui-form-label">
                    <span class="x-red">*</span>邮箱
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="email" name="email" required="" lay-verify="email"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="addr" class="layui-form-label">
                    <span class="x-red">*</span>地址
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="addr" name="addr" required="" lay-verify="addr"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><span class="x-red">*</span>角色</label>
                <div id="roles" class="layui-input-block">
<%--                    <input type="checkbox" name="like1[write]" lay-skin="primary" title="超级管理员" checked="">--%>
<%--                    <input type="checkbox" name="like1[read]" lay-skin="primary" title="编辑人员">--%>
<%--                    <input type="checkbox" name="like1[write]" lay-skin="primary" title="宣传人员" checked="">--%>
                </div>
            </div>

            <div class="layui-form-item">
                <label  class="layui-form-label">
                </label>
                <button  class="layui-btn" lay-filter="add" lay-submit="">
                    编辑
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form'], function () {
        form = layui.form;
    });
    $(function () {
        var data = eval('('+parent.empData+')');
        $("#empId").val(data.empId);
        $("#username").val(data.username);
        $("#empName").val(data.empName);
        $("#sex").val(data.sex);
        $("#tel").val(data.tel);
        $("#email").val(data.email);
        $("#addr").val(data.addr);

        $.ajax({
            type:"post",
            url:"findAllRoleByempId.ajax",
            data:{empId: data.empId},
            success:function (data) {
                var html="";
                for (var i=0;i<data.roles.length;i++)
                {
                    if(i==data.rid-1)
                    {
                        html+="    <input type=\"radio\" name=\"choose\" lay-skin=\"primary\" title="+data.roles[i].roleName+" value="+data.roles[i].roleId+" checked>";
                    }
                    else {
                        html+="    <input type=\"radio\" name=\"choose\" lay-skin=\"primary\" title="+data.roles[i].roleName+" value="+data.roles[i].roleId+" >";
                    }
                }
                $("#roles").html(html);
                form.render();
            },
            error:function () {
                alert("失败");
            }
        })
    });
    layui.use(['form', 'layer'],
    function() {

        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            nikename: function(value) {
                if (value.length < 5) {
                    return '昵称至少得5个字符啊';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
        });
        $.ajax({
            type:"post",
            url:"",
        })
        //监听提交
        form.on('submit(add)',
            function(data) {
                console.log(data);
                // alert(data.field);
                $.ajax({
                    url:"editEmp.ajax",
                    type:"get",
                    data:data.field,
                    dataType:"text",
                    success:function (data) {
                        if (data == "true"){
                            layer.alert("编辑成功", {
                                    icon: 6
                                },
                                function() {
                                    parent.load(parent.pageInfo);
                                    // 获得frame索引
                                    var index = parent.layer.getFrameIndex(window.name);
                                    //关闭当前frame
                                    parent.layer.close(index);
                                });
                        }else {
                            layer.alert("编辑失败", {
                                    icon: 5
                                },
                                function() {
                                    parent.load(parent.pageInfo);
                                    // 获得frame索引
                                    var index = parent.layer.getFrameIndex(window.name);
                                    //关闭当前frame
                                    parent.layer.close(index);
                                });
                        }
                    }
                })
                return false;
            });

    });</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>
