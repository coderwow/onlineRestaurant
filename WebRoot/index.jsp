<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="Helper.*" %>
<%@ page import="java.sql.*" %>
<%
	String name = (String)session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link href="images/title.ico" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/my.css">
    <!--<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">-->
</head>
<body class="container">
<header>
    <nav class="navbar navbar-inverse" role="navigation" style="background: #ffe9e2">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#my-navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="javascript:void(0)">zhouyang</a>
            </div>
            <div class="collapse navbar-collapse" id="my-navbar">
                <ul class="nav navbar-nav">
                    <li><a href="#" >首页</a></li>
                    <li><a href="#" >美食天地</a></li>
                    <li><a href="#" >今日优惠</a></li>
                    <li><a href="#" >购物车</a></li>
                    <li><a href="#" >关于我们</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>
<div class="content">
    <div class="row">
        <div class="col-md-3  content-left">
            <p><code class="lead"><%=name %></code>，你好！<br/><br/>欢迎进入订餐系统</p>
            <hr/>
            <div class="login-info">
                <ul>
                    <li><a href="shopping-cart.html">购物车 <span class="badge">3</span></a></li>
                    <li><a href="my-order.html">我的订单</a></li>
                </ul>
                <ul>
                    <li><a href="#">我的首页</a></li>
                    <li><a href="#">我的收藏</a></li>
                </ul>
                <ul>
                    <li><a href="#">注册信息管理</a></li>
                    <li><a href="address.html">常用送货地址</a></li>
                </ul>
                <a href="index.html" class="btn btn-info btn-login">退出登录</a>
            </div>
            <div class="well system-info">
                <dl>
                    <dt>系统信息</dt>
                    <dd>当前注册人数：<code>15</code>人</dd>
                </dl>
                <dl>
                    <dt>最新注册</dt>
                    <dd>2016-3-12 12:09:12 <code>kevin</code></dd>
                    <dd>2016-3-12 12:09:12 <code>kevin</code></dd>
                </dl>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">折扣信息</h3>
                </div>
                <div class="panel-body">
                    <p>满<code>50</code>元，<code>95</code>折</p>
                    <p>满<code>100</code>元，<code>90</code>折</p>
                    <p>满<code>200</code>元，<code>85</code>折</p>
                    <p>满<code>300</code>元，<code>90</code>折</p>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">订餐流程</h3>
                </div>
                <div class="panel-body">
                    <ol>
                        <li>选择菜品 &nbsp;<span class="glyphicon glyphicon-arrow-right"></span> 加入购物车</li>
                        <li>查看购物车 &nbsp;<span class="glyphicon glyphicon-arrow-right"></span> 下单</li>
                        <li>确认订单 &nbsp;<span class="glyphicon glyphicon-arrow-right"></span> 完成</li>
                    </ol>
                </div>
            </div>
        </div>
        <div class="col-md-8 " >
            <div class="page-header">
                <form role="form" class="form-inline">
                    <div class="form-group ">
                        菜品名称:
                        <input type="text" class="form-control search-food" id="foodname">
                    </div>
                    <div class="form-group">
                        价格:
                        <input type="text" class="form-control  search-price" > --
                        <input type="text" class="form-control search-price" >
                    </div>
                    <div class="checkbox">
                        类型：
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox1" value="option1"> 冷菜
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox2" value="option2"> 主菜
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox3" value="option3"> 靓汤
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" id="inlineCheckbox4" value="option4"> 主食
                        </label>
                    </div>
                    <button class="btn-warning btn" type="submit">search</button>
                </form>
            </div>
            <div class="main">
                <button class="btn btn-info" type="button">
                    搜索结果 <span class="badge">4</span>
                </button>
                <button class="btn btn-default pull-right" type="button">
                    清除搜索条件
                </button>
                
                <%
                	String sql = "select * from t_product where pstatus=1";
                	DbHelper db = new DbHelper();
                	Connection conn = db.GetConnection();
                	Statement st = conn.createStatement();
                	
                	ResultSet rs = st.executeQuery(sql);
                	while(rs.next())
                	{
                		
                %>
                
                	<div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/<%=rs.getString("ppic") %>" alt="..." class='img img-rounded' style='border:1px solid red;padding:2px;box-shadow:2px 2px #ccc;'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading"><%=rs.getString("pname") %></h4>
                             	<%=rs.getString("pdis") %>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】<%=rs.getString("pprice") %>元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
                
                <%
                		
                	}
                %>
               
               
            </div>
            <div class="page text-center">
                <nav>
                    <ul class="pagination">
                        <li><a href="#">&laquo;</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="text-center footer-info">
        <h3>上海立信会计金融学院+信息管理与信息系统+周杨</h3>
    </div>
</footer>
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>