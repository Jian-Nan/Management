<%--
  Created by IntelliJ IDEA.
  User: 文宏
  Date: 2020/8/3
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <title>库存</title>
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
<body onload="load(pageInfo)">
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
                <div class="layui-card-body layui-table-body layui-table-main">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>库存编号</th>
                            <th>商品名称</th>
                            <th>商品库存</th>
                            <th>库存上限</th>
                            <th>库存下限</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">

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
</html>
<script type="text/javascript">

    //页码信息
    var page = 1;
    var prePage;
    var nextPage;
    var firstPage;
    var endPage;
    var pageSize;

    var pageInfo = {
        page:page
    }

    layui.use(['laydate', 'form'], function () {
        var laydate = layui.laydate;
        var form = layui.form;

        // 监听全选
        form.on('checkbox(checkall)', function (data) {

            if (data.elem.checked) {
                $('tbody input').prop('checked', true);
            } else {
                $('tbody input').prop('checked', false);
            }
            form.render('checkbox');
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });


    function load(page) {
        var da = eval('(' + parent.json + ')');
        $.ajax({
            url: "/store/storeList.ajax",
            type: "get",
            data: pageInfo,
            dataType: "json",
            success: function (data) {
                var html = "";
                for (var i = 0; i < data.list.length; i++) {
                    html += "<tr>\n" +
                        "        <td>" + data.list[i].storeId + "</td>\n" +
                        "        <td>" + data.list[i].storeName + "</td>\n" +
                        "        <td>" + data.list[i].num + "</td>\n" +
                        "        <td>" + data.list[i].uNum + "</td>\n" +
                        "        <td>" + data.list[i].dNum + "</td>\n" +
                        "        <td class='td-status'>\n" +
                        "             <span class='layui-btn layui-btn-normal layui-btn-mini'>已启用</span></td>\n" +
                        "        <td class='td-manage'>\n" +
                        "        <a onclick=member_stop(this,'10001') href='javascript:;' title='停用'>\n" +
                        "           <i class='layui-icon'>&#xe601;</i>\n" +
                        "        </a>\n" +
                        "            <a title='修改' onclick=updateStore(this)\n" +
                        "               href='javascript:;'>\n" +
                        "                <i class='layui-icon'>&#xe642;</i>\n" +
                        "            </a>\n" +
                        "        </td>\n" +
                        "    </tr>"
                }
                $("#tbody").html(html);

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

                $("[id=pageid" + page + "]").prop("style", "color: #0000FF");
            }
        })
    }

    //首页
    $("#firstPage").click(function () {
        page = firstPage;
        load(page);
    });

    //上一页
    $("#prePage").click(function () {
        page = prePage;
        load(page);
    });

    //下一页
    $("#nextPage").click(function () {
        page = nextPage;
        load(page);
    });

    //尾页
    $("#endPage").click(function () {
        page = endPage;
        load(page);
    });

    //点击页码按钮
    function pageBtnClick(pageid) {
        page = pageid;
        load(page);
    }

    var store;

    function updateStore(btn) {
        store = JSON.stringify({
            storeId: $(btn).parent().parent().find("td").eq(0).text(),
            storeName: $(btn).parent().parent().find("td").eq(1).text(),
            num:$(btn).parent().parent().find("td").eq(2).text(),
            uNum: $(btn).parent().parent().find("td").eq(3).text(),
            dNum: $(btn).parent().parent().find("td").eq(4).text(),
        })
        xadmin.open('修改', '/store/updateStorePage.do', 600, 400);
    }

    /*库存-停用*/
    function member_stop(obj, id) {


        if ($(obj).attr('title') == '停用') {
            layer.confirm('确认要停用吗？', function (index) {
                //发异步把用户状态进行更改
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {icon: 5, time: 1000});
            })
        } else {
            layer.confirm('确认要启用吗？', function (index) {
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {icon: 6, time: 1000});
            })
        }

    }
</script>
