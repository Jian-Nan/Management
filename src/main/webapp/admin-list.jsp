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
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/static/js/xadmin.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">演示</a>
            <a>
              <cite>导航元素</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input class="layui-input" autocomplete="off" placeholder="开始日" name="start" id="start">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input class="layui-input" autocomplete="off" placeholder="截止日" name="end" id="end">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" id="searchUsername" name="username" placeholder="请输入用户名" autocomplete="off"
                                   class="layui-input">
                        </div>
<%--                        <div class="layui-inline layui-show-xs-block">--%>
<%--                            <button onclick="searchEmp()" class="layui-btn" lay-submit="" lay-filter="sreach"><i--%>
<%--                                    class="layui-icon">&#xe615;</i></button>--%>
<%--                        </div>--%>
                    </form>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除
                    </button>
                    <button class="layui-btn" onclick="xadmin.open('添加用户','admin-add.jsp',600,400)"><i
                            class="layui-icon"></i>添加
                    </button>
                    <div class="layui-inline layui-show-xs-block">
                        <button onclick="searchEmp()" class="layui-btn" lay-submit="" lay-filter="sreach"><i
                                class="layui-icon">&#xe615;</i></button>
                    </div>
                </div>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="" lay-skin="primary">
                            </th>
                            <th>员工编号</th>
                            <th>用户名</th>
                            <th>密码</th>
                            <th>员工姓名</th>
                            <th>性别</th>
                            <th>手机</th>
                            <th>邮箱</th>
                            <th>地址</th>
                            <th>状态</th>
                            <th>操作</th>

                        </thead>
                        <tbody id="emplist">
                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">

                        <%--分页按钮--%>
                        <div class="col offset-3">
                            <a href="#" class="num" id="firstPage">首页</a>
                            <a href="#" class="num" id="prePage">上一页</a>
                            <div style="display: inline-block" id="pageBtns"></div>
                            <a href="#" class="num" id="nextPage">下一页</a>
                            <a href="#" class="num" id="endPage">尾页</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        var page=1;
        $.ajax({
            type: "post",
            data: {page:page},
            url: "findAllEmp.ajax",
            success: success,
            error: function () {
                alert("失败");
            }
        });
    });
    //查询用户
    function searchEmp() {
        var username=$("#searchUsername").val();
        alert(username)
        $.ajax({
            type:"post",
            data:{username:username},
            url:"searchEmp.ajax",
            success: success,
            error: function () {
                alert("失败");
            }
        })
    }
    var page = 1;
    var prePage;
    var nextPage;
    var firstPage;
    var endPage;
    var pageSize;
    var pageInfo = {
        page: page
    }
     function load(pageInfo) {
         $.ajax({
             type: "post",
             data: {page:pageInfo.page},
             url: "findAllEmp.ajax",
             success: success,
             error: function () {
                 alert("失败");
             }
         });
     }
    function success(data) {
        var html = "";
        for (var i = 0; i < data.emps.length; i++) {
            html += "<tr>"+
                    "    <td><input type=\"checkbox\" name=\"\"  lay-skin=\"primary\">     </td>" +
                "<td>"+data.emps[i].empId+"</td>" +
                "<td>"+data.emps[i].username+"</td>" +
                "<td>"+data.emps[i].password+"</td>" +
                "<td>"+data.emps[i].empName+"</td>" +
                "<td>"+data.emps[i].sex+"</td>" +
                "<td>"+data.emps[i].tel+"</td>" +
                "<td>"+data.emps[i].email+"</td>" +
                "<td>"+data.emps[i].addr+"</td>" +
                "<td class=\"td-status\"><span class=\"layui-btn layui-btn-normal layui-btn-mini\">已启用</span></td>" +
                "<td class=\"td-manage\">\n" +
                "<a onclick=\"member_stop(this,'10001')\" href=\"javascript:;\"  title=\"启用\">\n" +
                "<i class=\"layui-icon\">&#xe601;</i>\n" +
                "</a>\n" +
                "<a title=\"编辑\"  onclick=updateEmp(this) href=\"javascript:;\">\n" +
                "<i class=\"layui-icon\">&#xe642;</i>\n" +
                "</a>\n" +
                "<a title=\"删除\" onclick=\"member_del(this,'要删除的id')\" href=\"javascript:;\">\n" +
                "<i class=\"layui-icon\">&#xe640;</i>\n" +
                "</a>\n" +
                "</td>"+
                "</tr>"
        }
        $("#emplist").html(html);
        page = data.nowPage;
        prePage = data.prePage;
        nextPage = data.nextPage;
        firstPage = data.firstPage;
        endPage = data.endPage;
        pageSize = data.pageSize;
        html = "";
        for (i = 1; i <= endPage; i++) {
            html += "&nbsp;<a href='#' onclick=pageBtnClick(" + i + ") class='num' id='pageid" + i + "'>" + i + "</a>"
        }
        $("#pageBtns").html(html);
    }

    layui.use(['laydate', 'form'], function () {
        var laydate = layui.laydate;
        var form = layui.form;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });


    function updateEmp(obj){
        empData=JSON.stringify({
            empId:$(obj).parent().parent().find("td").eq(1).text(),
            username:$(obj).parent().parent().find("td").eq(2).text(),
            password:$(obj).parent().parent().find("td").eq(3).text(),
            empName:$(obj).parent().parent().find("td").eq(4).text(),
            sex:$(obj).parent().parent().find("td").eq(5).text(),
            tel:$(obj).parent().parent().find("td").eq(6).text(),
            email:$(obj).parent().parent().find("td").eq(7).text(),
            addr:$(obj).parent().parent().find("td").eq(8).text(),

        })


        xadmin.open('编辑','admin-edit.jsp');
    }


    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {icon: 5, time: 1000});

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {icon: 5, time: 1000});
            }

        });
    }

    /*用户-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {icon: 1, time: 1000});
        });
    }


    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }

    //首页
    $("#firstPage").click(function () {
        pageInfo.page = firstPage;
        load(pageInfo);
    });

    //上一页
    $("#prePage").click(function () {
        pageInfo.page = prePage;
        load(pageInfo);
    });

    //下一页
    $("#nextPage").click(function () {
        pageInfo.page = nextPage;
        load(pageInfo);
    });

    //尾页
    $("#endPage").click(function () {
        pageInfo.page = endPage;
        load(pageInfo);
    });

    //点击页码按钮
    function pageBtnClick(pageid) {
        pageInfo.page = pageid;
        load(pageInfo);
    }

</script>
<script>var _hmt = _hmt || [];
(function () {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</html>
