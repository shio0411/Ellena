

# Release Summary `Employee page`
***Changes since last push from 14/6/2022 7:51PM***

***Release date: 14/6/2022 10:05PM***

## Milestones
- [x] add employee-order.jsp page
- [x] redirect employee to tawk.to page

## New files:
- employee-order.jsp
- `EmployeeShowOrderController`

## Changes in code:
- **`LoginController`**
    - Change `EMPLOYEE_PAGE = "employee.jsp"; ` to `EMPLOYEE_PAGE = "EmployeeShowOrderController";`

- **`AuthenFiller`**
    - Add:
        - Add list `EMPLOYEE_FUNCTION`
            ```
                private static List<String> EMPLOYEE_FUNCTION;
                private static final String EM = "EM";
            ```
        - Add list page and controllers employee's role can access
            ```
                EMPLOYEE_FUNCTION = new ArrayList<>();
                EMPLOYEE_FUNCTION.add("EmployeeShowOrderController");
                EMPLOYEE_FUNCTION.add("UpdateOrderController");
                EMPLOYEE_FUNCTION.add("SearchOrderController");
                EMPLOYEE_FUNCTION.add("employee-order.jsp");
            ```
        - Add Role confirmation
            ```
                (...)
                else if (EM.equals(roleID) && EMPLOYEE_FUNCTION.contains(resource)) {
                                chain.doFilter(request, response);
                            }
                (...)           
            ```

- **`ShowOrderController`**
    - Change from
        ```
            private static final String ERROR = "manager-order.jsp";
            private static final String SUCCESS = "manager-order.jsp";
        ```
        to
        ```
            private static final String MANAGER_SUCCESS = "manager-order.jsp";
        ```
    - Add 
        - Add new ERROR page url, employee success url and roles confirmation
            ```
                private static final String ERROR = "error.jsp";
                (...)
                private static final String EMPLOYEE_SUCCESS = "employee-order.jsp";
                private static final String MN = "MN";
                private static final String EM = "EM";
            ```
        - Get `LOGIN_USER` session
            ```
                HttpSession session = request.getSession();
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            ```
        - Roles confirmation
            ```
                switch (loginUser.getRoleID()) {
                    case MN:
                        url = MANAGER_SUCCESS;
                        break;
                    case EM:
                        url = EMPLOYEE_SUCCESS;
                        break;
                    default:
                        break;
                }
            ```
    - Remove `url = SUCCESS;`



## Discovered possible issues:
 1. 

## Note for later version:
- 



## Note considering for later version:
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

