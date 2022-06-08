<%-- 
    Document   : manager
    Created on : May 22, 2022, 7:57:21 AM
    Author     : Jason 2.0
--%>
<%@page import="javafx.util.Pair"%>
<%@page import="store.shopping.StatisticDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang chủ | Manager</title>
    <jsp:include page="meta.jsp" flush="true" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js">
    </script>
    
</head>

<body>
    <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            
        %>
    <div class="wrapper d-flex align-items-stretch">
        <nav class="side-nav color-3">
            <a href="ManagerStatisticController" style="color: #873e23; font-weight: bold;"><i class=""></i>Số liệu thống kê</a>
            <a href="manager-product.jsp"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-order.jsp"><i class=""></i>Quản lí đơn hàng</a>
        </nav>
        <%
                    StatisticDTO today = (StatisticDTO)request.getAttribute("ORDER_STATISTIC_TODAY");                    
                    %>
        <div class="content" class="p-4 p-md-5">
            <div class="container-fluid rounded color-bg p-3">
                <div class=" justify-content-between">
                    <div class="media col-sm-3 text-white align-items-center color-4 rounded py-3">
                        <img class="img-fluid" width="50" src="img/shopping-cart.png" alt="Đơn hàng" />
                        <div class="media-body text-right">
                            <h1 class="mt-0 mb-0"><b>
                                    <%=today.getOrderQuantity()%></b></h1>
                            <p>Đơn hàng</p>
                        </div>
                    </div>
                    <div class="media col-sm-3 text-white align-items-center color-2 rounded py-3 mt-0">
                        <img class="img-fluid" width="50" src="img/coins.png" alt="Đơn hàng" />
                        <div class="media-body text-right">
                            <h1 class="mt-0 mb-0"><b>
                                    <%=today.getIncome()%></b></h1>
                            <p>Doanh thu</p>
                        </div>
                    </div>
                    <div class="media col-sm-3 text-white align-items-center color-3 rounded py-3 mt-0">
                        <img class="img-fluid" width="50" src="img/clothes.png" alt="Đơn hàng" />
                        <div class="media-body text-right">
                            <h1 class="mt-0 mb-0"><b>
                                    <%=today.getProductQuantity()%></b></h1>
                            <p>Sản phẩm bán ra</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button">Thời gian</a>
                <div class="dropdown-menu nav-tabs" role="tablist">
                    <button class="dropdown-item nav-link btn btn-light" role="tab" type="button" data-toggle="tab" data-target="#chart1">7 ngày gần đây</button>
                    <button class="dropdown-item nav-link btn btn-light" role="tab" type="button" data-toggle="tab" data-target="#chart2">4 tuần gần đây</button>
                    <button class="dropdown-item nav-link btn btn-light" role="tab" type="button" data-toggle="tab" data-target="#chart3">12 tháng gần đây</button>
                </div>
            </div>
            <div class="container-fluid tab-content">
                <div id="chart1" class="tab-pane fade active in" role="tabpanel">
                    <h3>Số liệu 7 ngày gần đây</h3>
                    <canvas id="7DayChart"></canvas>
                </div>
                <div id="chart2" class="tab-pane fade" role="tabpanel">
                    <h3>Số liệu 4 tuần gần đây</h3>
                    <canvas id="4WeekChart"></canvas>
                </div>
                <div id="chart3" class="tab-pane fade" role="tabpanel">
                    <h3>Số liệu 12 tháng gần đây</h3>
                    <canvas id="1YearChart"></canvas>
                </div>
            </div>
            <%
                    Map<String, StatisticDTO> orderStatistic7Day = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_7DAY");
                    Map<String, StatisticDTO> orderStatistic4Week = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_4WEEK");
                    Map<String, StatisticDTO> orderStatistic1Year = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_1YEAR");
                    List<Pair<String, StatisticDTO>> bestSeller = (List<Pair<String, StatisticDTO>>) request.getAttribute("BEST_SELLER");
                    List<Pair<String, StatisticDTO>> bestIncome = (List<Pair<String, StatisticDTO>>) request.getAttribute("BEST_INCOME");  
                    Set<String> set7day = orderStatistic7Day.keySet();
                    Set<String> set4week = orderStatistic4Week.keySet();
                    Set<String> set1year = orderStatistic1Year.keySet();
                    List<String> list7day = new ArrayList<String>(set7day);
                    List<String> list4week = new ArrayList<String>(set4week);
                    List<String> list1year = new ArrayList<String>(set1year);
                    Collections.sort(list7day);
                    Collections.sort(list4week);
                    Collections.sort(list1year);                            

                %>
            <div class="container-fluid">
                <h2>Sản phẩm bán chạy nhất:</h2>
                <div class="row row-content align-items-center">
                    <%
                int cnt = 1;
                for(Pair<String, StatisticDTO> p : bestSeller){
                    %>
                    <div class="card rounded ml-2 py-5 col-12 col-md-2">
                        <div class="card-header ">
                            <span class="badge badge-primary">
                                <%=cnt++%></span>
                            <h4 class=""><b>
                                    <%=p.getKey()%></b></h4>
                        </div>
                        <div class="card-body">
                            <div>Mã sản phẩm:
                                <%=p.getValue().getOrderQuantity()%>
                            </div>
                            <div>Số lượng bán được:
                                <%=p.getValue().getIncome()%>
                            </div>
                        </div>
                    </div>
                    <%
                }
            %>
                </div>
                <h2>Sản phẩm có doanh thu cao nhất:</h2>
                <div class="row row-content align-items-center">
                    <%
                cnt = 1;
                for(Pair<String, StatisticDTO> p : bestIncome){
                    %>
                    <div class="col-12 col-sm-2">
                        <span class="badge badge-primary">
                            <%=cnt++%></span>
                        <h4><b>
                                <%=p.getKey()%></b></h4>
                        <div>Mã sản phẩm:
                            <%=p.getValue().getOrderQuantity()%>
                        </div>
                        <div>Doanh thu:
                            <%=p.getValue().getProductQuantity()%>
                        </div>
                    </div>
                    <%
                }
            %>
                </div>
            </div>
        </div>
    </div>
    <script>
    /*$("[data-target="#30DayChart"]").on       $("#orderchat")*/
    </script>
    <script type="text/javascript">
    var ctx = document.getElementById("7DayChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%for (String key : list7day) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Order quantity',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#873e23",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'income',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: "#93A3B1",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Product quantity',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#FCA17D",
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            },
            interaction: {
                mode: 'point'
            }
        }
    });
    </script>
    <script type="text/javascript">
    var ctx = document.getElementById("4WeekChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%for (String key : list4week) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Order quantity',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#873e23",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'income',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: "#93A3B1",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Product quantity',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#FCA17D",
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            }
        }
    });
    </script>
    <script type="text/javascript">
    var ctx = document.getElementById("1YearChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%for (String key : list1year) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Order quantity',
                    data: [<%for (String key : list1year) {
                                        %>
                        "<%=orderStatistic1Year.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#873e23",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'income',
                    data: [<%for (String key : list1year) {
                                        %>
                        "<%=orderStatistic1Year.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: "#93A3B1",
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Product quantity',
                    data: [<%for (String key : list1year) {
                                        %>
                        "<%=orderStatistic1Year.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: "#FCA17D",
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            }
        }
    });
    </script>
</body>

</html>
