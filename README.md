

# Release Summary footer pages
***Changes since last push from 20/6/2022 10:123PM***

***Release date: 21/6/2022 12:06AM***

## Milestones
- 

## New files:
- payment-policy.jsp
- return-policy.jsp


## Changes in code:
- `AuthenFilter`
    - Add uri for none login user:
        ```java
            (
            (...)
                || uri.contains("choose-size.jsp") || uri.contains("payment-policy.jsp") || uri.contains("return-policy.jsp") ) 
            (...)
        ```
- footer.jsp
    - fix hyperlink to the correct pages


## Discovered possible issues:
 1. 

## Note for later version:
- 

## Note considering for later version:
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

