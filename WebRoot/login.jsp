<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Helper.*"%>
<%@ page import="java.util.*" %>
<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	String date=df.format(new Date());// new Date()为获取当前系统时间
	
	//清除session里面的东西 
	session.setAttribute("username",null);
   	session.setAttribute("userstatus",null);
	
	//用户登录
	 String msg_load="";
	 String load = request.getParameter("load");
	 if(load!=null && load.equals("yes"))
	 {
	 	String username=request.getParameter("tel");
	 	String password=request.getParameter("pass");
	 	if(username.isEmpty())
	 	{
	 		msg_load="输入账号";
	 	}
	 	else if(password.isEmpty())
	 	{
	 		msg_load="输入密码";
	 	}
	 	else 
	 	{
		 	DbHelper dbcon = new DbHelper();
		 	Connection conn = dbcon.GetConnection();
		 	String sql = "select cid,cstatus from t_customer where cusername='"+username+"' and cpassword='"+password+"'";
		 	Statement st = conn.createStatement();
	        ResultSet rs = st.executeQuery(sql);
	        if(rs.next())
	        {
	        	int cid = rs.getInt("cid");
	        	session.setAttribute("username",username );
	        	session.setAttribute("userstatus",rs.getString("cstatus"));
	        	sql ="update t_customer set cload_time='"+date+"' where cid="+cid;
	        	st.executeUpdate(sql);
	        	st.close();
	        	conn.close();
	        	response.sendRedirect("index.jsp");
	        }
	        else
	        {
		        st.close();
		        conn.close();
		        msg_load="账号密码错误";
	        }
	 	}	
	 }
	 
	 //用户注册 
	 String msg_reg = "";
	 String insert = request.getParameter("insert");
	 if(insert!=null && insert.equals("yes"))
	 {
	 	String username=request.getParameter("username_reg");
	 	String password=request.getParameter("password_reg");
	 	if(username.isEmpty())
	 	{
	 		msg_reg="输入账号";
	 	}
	 	else if(password.isEmpty())
	 	{
	 		msg_reg="输入密码";
	 	}
	 	else 
	 	{
		 	DbHelper dbcon = new DbHelper();
		 	Connection conn = dbcon.GetConnection();
		 	String sql = "select cid from t_customer where cusername='"+username+"'";
		 	Statement st = conn.createStatement();
	        ResultSet rs = st.executeQuery(sql);
	        if(rs.next())
	        {
	        	msg_reg="账号已存在";
	        }
	        else
	        {
	        	sql="insert into t_customer values(null,'"+username+"','"+password+"','"+date+"',1,'"+date+"')";
	        	st.executeUpdate(sql);
	        	session.setAttribute("username",username );
	        	session.setAttribute("userstatus","1");
		        st.close();
		        conn.close();
		        response.sendRedirect("index.jsp");
	        }
	 	}
 	}	
	 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>index</title>
    <link href="images/title.ico" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/my.css">
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
            <h3 class="text-center">用户登录</h3>
            <form role="form" action='login.jsp?load=yes' class="form-horizontal">
            	<input type="hidden" name='load' value="yes"/>
                <div class="form-group form-group-sm">
                    <label class="control-label col-md-3  col-xs-3" for="username">手机</label>
                    <div class="col-md-8 col-xs-6">
                        <input type="text" class="form-control" placeholder="phone" name='tel'/>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <label class="control-label col-md-3 col-xs-3" for="password">密码</label>
                    <div class="col-md-8 col-xs-6">
                        <input type="password" class="form-control" placeholder="password" name='pass'/>
                    </div>
                </div>
                <p class='help-block col-md-offset-4'><%=msg_load %></p>
                <p class="text-center"><button class="btn btn-primary" type='submit'>登录</button></p>
                <p class="text-center"><a class="btn btn-primary" href="register.html">新用户注册</a></p>
            </form>
            <hr/>
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
               <div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/duck.jpg" alt="..." class='img img-rounded'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading">水果蛋炒饭</h4>
                               水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】200元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
               <div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/duck.jpg" alt="..." class='img img-rounded'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading">水果蛋炒饭</h4>
                               水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】200元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
               <div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/duck.jpg" alt="..." class='img img-rounded'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading">水果蛋炒饭</h4>
                               水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】200元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
               <div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/duck.jpg" alt="..." class='img img-rounded'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading">水果蛋炒饭</h4>
                               水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】200元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
               <div class="row main-content">
                   <div class="col-md-7">
                       <div class="media">
                           <a class="media-left media-middle" href="#">
                               <img src="images/duck.jpg" alt="..." class='img img-rounded'>
                           </a>
                           <div class="media-body ">
                               <h4 class="media-heading">水果蛋炒饭</h4>
                               水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭水果蛋炒饭
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3">
                       <p>【价格】200元/份</p>
                   </div>
                   <div class="col-md-2">
                       <ul class="list-unstyled">
                           <li><a href="#">收藏</a></li>
                           <li><a href="#">加入购物车</a></li>
                       </ul>
                   </div>
               </div>
                
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