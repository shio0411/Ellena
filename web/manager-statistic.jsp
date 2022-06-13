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
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2/dist/Chart.min.js"></script>
    </script>
    
</head>

<body>
    <%!
        public String addDot(Integer number){
        String str = String.format("%,d", number);
        return str;
    }
    %>
    <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            
        %>
       
    <div class="wrapper d-flex align-items-stretch">
        <nav class="side-nav bg-color-primary d-flex flex-column p-3 shadow"> 
            <img src="./img/ellena-logo-typo.png" class="img-fluid mx-auto" width="120px"/>
            <a class="pt-5" href="ManagerStatisticController" style="color: #873e23; font-weight: bold;"><i style="color: #873e23;" class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="manager.jsp"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </nav>
        <%
            StatisticDTO today = (StatisticDTO)request.getAttribute("ORDER_STATISTIC_TODAY");                    
        %>
        <div id="content" class="p-3 px-5">
            <form action="MainController" method="POST">  
                <div class="row ml-5">
                <h4 class="col-6">
                    <b>Xin chào, </b>
                        <a data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                    <div class="dropdown-menu nav-tabs" role="tablist">
                    <button class="dropdown-item btn" role="tab" type="button"><a class="text-dark" href="my-profile.jsp">Thông tin tài khoản</a></button>
                    <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                </div>
                </h4>
                
           
                </div>
            </form>
            <hr class="mx-5 mb-5"/>
            <div class="container-fluid rounded p-3 mb-4 color-bg">
                <h4 class="mb-4 text-center"><b>Thống kê hôm nay</b></h4>
                <div class="d-flex flex-column flex-md-row justify-content-md-around">
                    <div class="card col-12 col-md-3 color-4 shadow  text-white rounded border-0">
                        <div class="row no-gutters">
                            <div class="col-4 text-center">
                                <img class="mt-4" height="50px" src="img/shopping-cart.png" alt="Đơn hàng" />
                            </div>
                            <div class="col-8 text-right">
                                <h2 class="mt-4 mb-0 mr-4"><b>
                                        <%=today.getOrderQuantity()%>
                                    </b></h2>
                                <p class="mb-4 mr-4">Đơn hàng</p>
                            </div>
                        </div>
                    </div>
                    <div class="card col-12 col-md-3 text-white shadow  color-2 rounded border-0">
                        <div class="row no-gutters">
                            <div class="col-4 text-center">
                                <img class="mt-4" height="50px" src="img/coins.png" alt="Đơn hàng" />
                            </div>
                            <div class="col-8 text-right">
                                <h2 class="mt-4 mb-0 mr-4"><b>
                                        <%=today.getIncome()%>
                                    </b></h2>
                                <p class="mb-4 mr-4">Doanh thu</p>
                            </div>
                        </div>
                    </div>
                    <div class="card col-12 col-md-3 text-white shadow  color-3 rounded border-0">
                        <div class="row no-gutters">
                            <div class="col-4 text-center">
                                <img class="mt-4" height="50px" src="img/clothes.png" alt="Đơn hàng" />
                            </div>
                            <div class="col-8 text-right">
                                <h2 class="mt-4 mb-0 mr-4"><b>
                                        <%=today.getProductQuantity()%>
                                    </b></h2>
                                <p class="mb-4 mr-4">Sản phẩm</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="mx-5 mb-5"/>
            <div class="rounded color-bg p-3 tab-content mb-4">
                <div class="container-fluid nav-item p-0 pr-4">
                    <h4 class="mb-4 text-center"><b> Số lượng đơn hàng, doanh thu và sản phẩm bán được</b></h4>
                    <div class="text-right" role="tablist">
                        <button class="btn btn-light border" role="tab" type="button" data-toggle="tab" data-target="#chart1">7
                            ngày</button>
                        <button class="btn btn-light border" role="tab" type="button" data-toggle="tab" data-target="#chart2">4
                            tuần</button>
                        <button class=" btn btn-light border" role="tab" type="button" data-toggle="tab" data-target="#chart3">12
                            tháng</button>
                    </div>
                </div>
             
                    <div id="chart1" class="col-10 tab-pane fade active in m-auto" role="tabpanel">
                        <canvas id="7DayChart"></canvas>
                    </div>
                    <div id="chart2" class="col-10 tab-pane fade m-auto" role="tabpanel">
                        <canvas id="4WeekChart"></canvas>
                    </div>
                    <div id="chart3" class="col-10 tab-pane fade m-auto" role="tabpanel">
                        <canvas id="1YearChart"></canvas>
                    </div>
                
            </div>
            <hr class="mx-5 mb-5"/>
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
            <div class="container-fluid rounded color-bg p-3 mb-4">
                <h4 class="text-center"><b>Sản phẩm bán chạy nhất</b></h4>
                <div class="row p-4">
                    <%
                int cnt = 1;
                for(Pair<String, StatisticDTO> p : bestSeller){
                    %>
                    <div class="card ml-4 p-0 col-12 col-sm border-0 shadow rounded">
                        <div class="card-block text-center">
                            <div class="color-<%=2+(cnt+1)%3%> text-white p-2 mb-3">
                                <h3><b><%=p.getValue().getIncome()%></b></h3>
                                <span>Sản phẩm bán được</span>
                            </div>
                            <div class="px-3 ">
                                <h6 class="card-title mb-2"><b><%cnt++;%><%=p.getKey()%></b></h6>
                                <p class="card-text mb-0">Mã sản phẩm: <%=p.getValue().getOrderQuantity()%></p>
                            </div>
                        </div>
                    </div>
                           
                    <%
                }
            %>
                </div>
            </div>
            <hr class="mx-5 mb-5"/>
            <div class="container-fluid rounded color-bg p-3 mb-4">
                <h4 class="text-center"><b>Sản phẩm có doanh thu cao nhất</b></h4>
                <div class="row p-4">
                    <%
                cnt = 1;
                for(Pair<String, StatisticDTO> p : bestIncome){
                    %>
                    <div class="card ml-4 p-0 col-12 col-sm rounded border-0 shadow">
                        <div class="card-block text-center">
                            <div class="color-<%=2+(cnt+1)%3%> text-white p-2 mb-3">
                                <h4><b><%=addDot(p.getValue().getProductQuantity())%>đ</b></h4>
                                <span>Doanh thu</span>
                            </div>
                                <div class="px-3 ">
                            <h6 class="card-title mb-2"><b><%cnt++;%><%=p.getKey()%></b></h6>
                            <p class="card-text mb-0">Mã sản phẩm: <%=p.getValue().getOrderQuantity()%></p>
                                </div>
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
        var canvas = document.getElementById('7DayChart');
        var ctx = canvas.getContext('2d');

        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        var gradient1 = ctx.createLinearGradient(500,0, 500, 500);
        var gradient2 = ctx.createLinearGradient(500,0, 500, 500);
        var gradient3 = ctx.createLinearGradient(500,0, 500, 500);
        // Add three color stops
        gradient1.addColorStop(0, '#344055');
        gradient1.addColorStop(1, '#93a3b1');

        gradient2.addColorStop(0.5, '#93a3b1');
        gradient2.addColorStop(1, '#ccffff');

        gradient3.addColorStop(0, '#fca17d');
        gradient3.addColorStop(1, '#ffcccc');
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
                    label: 'Đơn hàng',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient1,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Doanh thu(VNĐ)',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient2,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Số sản phẩm',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient3,
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
            legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
            }
        }
    });
    </script>
    <script type="text/javascript">
    var canvas = document.getElementById('4WeekChart');
    var ctx = canvas.getContext('2d');

    // Create a linear gradient
    // The start gradient point is at x=20, y=0
    // The end gradient point is at x=220, y=0
    var gradient1 = ctx.createLinearGradient(500,0, 500, 500);
    var gradient2 = ctx.createLinearGradient(500,0, 500, 500);
    var gradient3 = ctx.createLinearGradient(500,0, 500, 500);
    // Add three color stops
    gradient1.addColorStop(0, '#344055');
    gradient1.addColorStop(1, '#93a3b1');

    gradient2.addColorStop(0.5, '#93a3b1');
    gradient2.addColorStop(1, '#ccffff');

    gradient3.addColorStop(0, '#fca17d');
    gradient3.addColorStop(1, '#ffcccc');
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
                    label: 'Đơn hàng',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient1,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Doanh thu(VNĐ)',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient2,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Số sản phẩm',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient3,
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
                legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
            }
        }
    });
    </script>
    <script type="text/javascript">
        var canvas = document.getElementById('1YearChart');
        var ctx = canvas.getContext('2d');

        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        var gradient1 = ctx.createLinearGradient(500,0, 500, 500);
        var gradient2 = ctx.createLinearGradient(500,0, 500, 500);
        var gradient3 = ctx.createLinearGradient(500,0, 500, 500);
        // Add three color stops
        gradient1.addColorStop(0, '#344055');
        gradient1.addColorStop(1, '#93a3b1');
        
        gradient2.addColorStop(0.5, '#93a3b1');
        gradient2.addColorStop(1, '#ccffff');
        
        gradient3.addColorStop(0, '#fca17d');
        gradient3.addColorStop(1, '#ffcccc');
        
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
                        label: 'Đơn hàng',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getOrderQuantity()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient1,
                        borderColor: [

                        ],
                        borderWidth: 1
                    },
                    {
                        label: 'Doanh thu(VNĐ)',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getIncome()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient2,
                        borderColor: [

                        ],
                        borderWidth: 1
                    },
                    {
                        label: 'Số sản phẩm',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getProductQuantity()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient3,
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
                legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
                }
            }             
            
        });
    </script>
    
</body>

</html>
