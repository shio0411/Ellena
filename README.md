# update:

- main controller: add 2 cases: search-order, update-order
- private static final String SEARCH_ORDER = "SearchOrder";
- private static final String SEARCH_ORDER_CONTROLLER = "SearchOrderController";
- private static final String UPDATE_ORDER = "UpdateOrder";
- private static final String UPDATE_ORDER_CONTROLLER = "UpdateOrderController";




# add new:

- manager-order.jsp
- UpdateOrderController.java
- ShowOrderController.java
- OrderDTO.java
- OrderDAO.java
- OrderDetailDTO.java
- OrderStatusDTO.java

- LoginGoogleController
- LoginFacebookController

- change link to manager-order in other 3 manager jsp

- add restfb-2.3.0.jar

# Filter
- MANAGER_FUNCTION.add("ManagerShowOrderController");
- MANAGER_FUNCTION.add("UpdateOrderController");
- MANAGER_FUNCTION.add("manager-order.jsp");
- add 2 uri :
  + uri.contains("LoginGoogleController") || uri.contains("LoginFacebookController")
-----------

